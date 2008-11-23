Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 127FEDDDFA
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Nov 2008 11:26:30 +1100 (EST)
Date: Sat, 22 Nov 2008 18:26:15 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: badness in xics_set_cpu_giq on JS20 blade
Message-ID: <20081123002615.GW6830@localdomain>
References: <20081122030653.GU6830@localdomain>
	<f35ce64a4d02ccbf84d3288dad3dc0f8@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f35ce64a4d02ccbf84d3288dad3dc0f8@bga.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
> On Sat Nov 22 at 14:06:53 EST in 2008, Nathan Lynch wrote:
>> With 2.6.28-rc5 the WARN_ON in xics_set_cpu_giq is triggering on a
>> JS20.  I changed it to a WARN to get the actual status returned:
>>
>> [boot]0020 XICS Init
>> set-indicator returned -22
>> ------------[ cut here ]------------
>> Badness at arch/powerpc/platforms/pseries/xics.c:733
> ...
>> Call Trace:
>> [c0000000006b3ca0] [c000000000047450] .xics_set_cpu_giq+0x50/0x68  
>> (unreliable)
>> [c0000000006b3d10] [c0000000005927b8] .xics_init_IRQ+0x2f4/0x338
>> [c0000000006b3de0] [c000000000591bcc] .pseries_xics_init_IRQ+0x14/0x2c
>> [c0000000006b3e60] [c000000000580488] .init_IRQ+0x40/0x5c
>> [c0000000006b3ee0] [c0000000005787d8] .start_kernel+0x250/0x478
>> [c0000000006b3f90] [c0000000000083b8] .start_here_common+0x1c/0x64
> ...
>> -22 is -EINVAL, which maps to a -3 return code from RTAS (see
>> rtas_error_rc).
>>
>> The system appears to boot and function normally after this, though.
>> FWIW, it looks like its firmware is up to date (FW08401160 from March
>> 2008).
>
> b4963255ad5a426f04a0bb15c4315fa4bb40cde9 "Factor out cpu  
> joining/unjoining the GIQ" consolidated the join and remove call sites.  
> Looking closer it also added warn if rtas-indicator returned an error on 
> join in addition to leave.

Thanks, that makes it clear why we didn't see the warning before.


> I don't have my PAPR here, but from rtas_error_rc (rtas.c) -3 is /* Bad  
> indicator/domain/etc */.  This indicator was added to support cpu add  
> and remove.  I'm guessing js20 doesn't support that from rtas (ie  
> doesn't support cpu hotadd), and the indicator is not available.  (I  
> know js21 has it because I had a bit of time to see its broken emulation 
> of this call once).

Right, JS20 doesn't support cpu offline so it makes sense that the
indicator isn't valid.


> When we get control of a cpu from OF it is already in the joined state.  
> We join on all threads because we need to do so on secondary threads and 
> because we did a remove on (previously all, but now secondary) threads 
> during kexec.
>
> If memory serves, there is a property in the rtas node to indicate each  
> sensor that is present.  If so, we should search for that property  
> before calling set-indicator.

I checked PAPR; it looks like we should be looking for an
rtas-indicators property, which doesn't exist on this system.  It does
exist on Power5 and Power6 systems I've checked, and it has the
expected entry for GIQ (9005).

Something like this?  I've booted it on the problem JS20 as well as
Power5 and 6.

 arch/powerpc/include/asm/rtas.h       |    1 +
 arch/powerpc/kernel/rtas.c            |   22 ++++++++++++++++++++++
 arch/powerpc/platforms/pseries/xics.c |   11 ++++++++---
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 8eaa7b2..4846f1f 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -168,6 +168,7 @@ extern void rtas_os_term(char *str);
 extern int rtas_get_sensor(int sensor, int index, int *state);
 extern int rtas_get_power_level(int powerdomain, int *level);
 extern int rtas_set_power_level(int powerdomain, int level, int *setlevel);
+extern bool rtas_indicator_present(int indicator);
 extern int rtas_set_indicator(int indicator, int index, int new_value);
 extern int rtas_set_indicator_fast(int indicator, int index, int new_value);
 extern void rtas_progress(char *s, unsigned short hex);
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 1f8505c..6cd2434 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -566,6 +566,28 @@ int rtas_get_sensor(int sensor, int index, int *state)
 }
 EXPORT_SYMBOL(rtas_get_sensor);
 
+bool rtas_indicator_present(int indicator)
+{
+	int proplen, count, i;
+	const struct indicator_elem {
+		u32 token;
+		u32 maxindex;
+	} *indicators;
+
+	indicators = of_get_property(rtas.dev, "rtas-indicators", &proplen);
+	if (!indicators)
+		return false;
+
+	count = proplen / sizeof(struct indicator_elem);
+
+	for (i = 0; i < count; i++)
+		if (indicators[i].token == indicator)
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL(rtas_indicator_present);
+
 int rtas_set_indicator(int indicator, int index, int new_value)
 {
 	int token = rtas_token("set-indicator");
diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index e190477..7f8fa33 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -728,9 +728,14 @@ static void xics_set_cpu_priority(unsigned char cppr)
 /* Have the calling processor join or leave the specified global queue */
 static void xics_set_cpu_giq(unsigned int gserver, unsigned int join)
 {
-	int status = rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
-		(1UL << interrupt_server_size) - 1 - gserver, join);
-	WARN_ON(status < 0);
+	int status;
+
+	if (!rtas_indicator_present(GLOBAL_INTERRUPT_QUEUE))
+		return;
+
+	status = rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
+			(1UL << interrupt_server_size) - 1 - gserver, join);
+	WARN(status < 0, "set-indicator returned %d\n", status);
 }
 
 void xics_setup_cpu(void)
