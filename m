Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0C6C7DDF1D
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 21:51:12 +1100 (EST)
Message-ID: <47E4E421.8060806@denx.de>
Date: Sat, 22 Mar 2008 11:49:05 +0100
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Oops with TQM5200 on TQM5200
References: <47E2723D.1090101@grandegger.com> <47E281B6.20702@denx.de>	
	<47E28E15.2070809@semihalf.com>
	<fa686aa40803201427r2a756fd9v54f88b6e95a20aab@mail.gmail.com>
In-Reply-To: <fa686aa40803201427r2a756fd9v54f88b6e95a20aab@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Thu, Mar 20, 2008 at 10:17 AM, Bartlomiej Sieka <tur@semihalf.com> wrote:
>> Anatolij Gustschin wrote:
>>  > Hello Wolfgang,
>>  >
>>  > Wolfgang Grandegger wrote:
>>  >
>>  >> I just tried Linux 2.6.25-rc6 on my TQM5200 module and got the attached
>>  >> oops. Are there any known patches fixing the problems?
>>  >
>>  > try the patch below for tqm5200.dts, rebuild dtb and boot
>>  > again. Not sure if it works for Linux 2.6.25-rc6, but for
>>  > 2.6.25-rc3 it does.
>>
>>  It helps 2.6.25-rc6 too - thanks Anatolij.
>>
>>
>>  >
>>  > Anatolij
>>  > --
>>  > diff --git a/arch/powerpc/boot/dts/tqm5200.dts
>>  > b/arch/powerpc/boot/dts/tqm5200.dts
>>  > index c86464f..7c23bb3 100644
>>  > --- a/arch/powerpc/boot/dts/tqm5200.dts
>>  > +++ b/arch/powerpc/boot/dts/tqm5200.dts
>>  > @@ -83,6 +83,7 @@
>>  >         };
>>  >
>>  >         dma-controller@1200 {
>>  > +            device_type = "dma-controller";
>>
>>  This actually fixes the Oops.
> 
> Hmm, this sounds like a band-aid; the kernel shouldn't oops if this is
> missing from the device tree.  Fail, perhaps, but oops is worrisome.
> Would someone like to investigate?

results of some further investigation:

the "bestcomm-core" driver defines its of_match table as follows
static struct of_device_id mpc52xx_bcom_of_match[] = {
	{ .type = "dma-controller", .compatible = "fsl,mpc5200-bestcomm", },
	{ .type = "dma-controller", .compatible = "mpc5200-bestcomm", },
	{},
};

so while registering the driver the drivers probe function won't be
called because of_match_node shows unexpected behavior in the case
that device tree node lacks device_type = "dma-controller" definition.

here is the current of_match_node code for quick reference:
drivers/of/base.c:309
const struct of_device_id *of_match_node(const struct of_device_id *matches,
					 const struct device_node *node)
{
	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
		int match = 1;
		if (matches->name[0])
			match &= node->name
				&& !strcmp(matches->name, node->name);
		if (matches->type[0])
			match &= node->type
				&& !strcmp(matches->type, node->type);
		if (matches->compatible[0])
			match &= of_device_is_compatible(node,
						matches->compatible);
		if (match)
			return matches;
		matches++;
	}
	return NULL;
}

So, the bestcomm-core driver provided the type field, but the
device tree node lacks it. The "if (matches->type[0])" case is true
and "node->type && !strcmp(matches->type, node->type)" evaluates to
zero, so match flag is set to zero. Now there is still a chance that
compatible property will match but even if it is the case, match flag
remains zero:
 "match &= of_device_is_compatible(node, matches->compatible)" always
sets match flag to zero if match was zero previously. of_match_node
returns NULL, the bestcomm-core driver probe won't be called and thus
the drivers bcom_engine structure won't be allocated. Referencing this
structure later causes observed Oops.

Checking bcom_eng pointer for NULL before referencing data pointed
by it prevents oopsing, but fec driver still doesn't work (because
of the lost bestcomm match and resulted task allocation failure).
Actually the compatible property exists and should match and so
the fec driver shoud work.

I suggest removing .type = "dma-controller" from the bestcomm driver's
mpc52xx_bcom_of_match table to solve the problem.

What do you think?

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm.c b/arch/powerpc/sysdev/bestcomm/bestcomm.c
index f589999..137d830 100644
--- a/arch/powerpc/sysdev/bestcomm/bestcomm.c
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm.c
@@ -484,8 +484,8 @@ mpc52xx_bcom_remove(struct of_device *op)
 }
 
 static struct of_device_id mpc52xx_bcom_of_match[] = {
-	{ .type = "dma-controller", .compatible = "fsl,mpc5200-bestcomm", },
-	{ .type = "dma-controller", .compatible = "mpc5200-bestcomm", },
+	{ .compatible = "fsl,mpc5200-bestcomm", },
+	{ .compatible = "mpc5200-bestcomm", },
 	{},
 };
 
