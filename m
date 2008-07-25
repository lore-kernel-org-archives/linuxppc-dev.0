Return-Path: <wg@grandegger.com>
Message-ID: <4889EE4C.9040705@grandegger.com>
Date: Fri, 25 Jul 2008 17:16:28 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: 85xx: add proper OF bus ids for the TQM85xx
References: <48898470.80109@grandegger.com>
	<fa686aa40807250620r1ab574basd07ecce6be2bc238@mail.gmail.com>
In-Reply-To: <fa686aa40807250620r1ab574basd07ecce6be2bc238@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Fri, Jul 25, 2008 at 3:44 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Since recent modifications to the MPC I2C code, the MPC I2C buses are not
>> found any more. This patch fixes the problem by adding proper OF
>> bus ids.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
>> arch/powerpc/platforms/85xx/tqm85xx.c |    6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> Index: linux-2.6-galak/arch/powerpc/platforms/85xx/tqm85xx.c
>> ===================================================================
>> --- linux-2.6-galak.orig/arch/powerpc/platforms/85xx/tqm85xx.c
>> +++ linux-2.6-galak/arch/powerpc/platforms/85xx/tqm85xx.c
>> @@ -156,15 +156,15 @@ static void tqm85xx_show_cpuinfo(struct }
>>
>> static struct of_device_id __initdata of_bus_ids[] = {
>> +       { .type = "soc", },
>> +       { .compatible = "soc", },
>>        { .compatible = "simple-bus", },
> 
> Ugh, i assume this is to support older .dts files that don't have
> simple-bus in their compatible property?  Please put them at the end
> of the list and put a comment ahead of them stating that they are
> legacy support.  You should also state in the comment which boards or
> dts files these entries provide support for.

Ah, I see. For the TQM8548 adding the following compatible line:

         soc8548@e0000000 {
		...
		compatible = "fsl,mpc8548-immr", "simple-bus"; 


solved my issues. All other DTS files for the TQM85xx modules have this 
line. It got lost somehow for the TQM8548. Thanks for pointing me to the 
real problem. Forget this patch, I will send a new one fixing the DTS file.

Wolfgang.
