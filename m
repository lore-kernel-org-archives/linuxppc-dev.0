Return-Path: <per.hallsmark@t2data.se>
Received: from t2data.se (unknown [212.247.174.226])
	by ozlabs.org (Postfix) with ESMTP id 6F7E967A46
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Feb 2005 02:11:07 +1100 (EST)
Received: from webmail ([192.168.1.7]) by t2data.se (t2data.se [172.16.0.3])
	(MDaemon.PRO.v7.2.2.R) with ESMTP id md50000103342.msg
	for <linuxppc-embedded@ozlabs.org>; Thu, 03 Feb 2005 16:02:30 +0100
Date: Thu, 3 Feb 2005 16:02:28 +0100
Sender: Per Hallsmark <per.hallsmark@t2data.se>
From: Per Hallsmark <per.hallsmark@t2data.se>
To: Jaap-Jan Boor <jjboor@aimsys.nl>
Message-ID: <41FFBC9A@webmail>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: Question about cpm reset on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for replying,

Yes, probably the 8260 code evolved from the 8xx code?
Personally I like to code so logic is reset'd to a known base
even if that means we have to go through some setup steps again.

Of course, there could be a reason why it is like it is
and that's why I sent out the question...

We have a problem where hdlc sometimes seems to lookup, when the ppc
reboots it doesn't helps but after a while it is reseted by harder
means (pulling the resetline) which helps. Testing the change right now,
but it can take long time before it happens...

>===== Original Message From Jaap-Jan Boor <jjboor@aimsys.nl> =====
>On Thu, 2005-02-03 at 15:29, Per Hallsmark wrote:
>> Hi all,
>>
>> Working with a board using hdlc over SCC channel (852T) and kernel 2.4.21,
>> in the cpm reset code in arch/ppc/8xx_io/commproc.c it's like:
>>
>> void
>> m8xx_cpm_reset()
>> {
>>         volatile immap_t         *imp;
>>         volatile cpm8xx_t       *commproc;
>>         pte_t                   *pte;
>>
>>
>>         imp = (immap_t *)IMAP_ADDR;
>>         commproc = (cpm8xx_t *)&imp->im_cpm;
>>
>>
>> #ifdef CONFIG_UCODE_PATCH
>>         /* Perform a reset.
>>         */
>>         commproc->cp_cpcr = (CPM_CR_RST | CPM_CR_FLG);
>>
>>
>>         /* Wait for it.
>>         */
>>         while (commproc->cp_cpcr & CPM_CR_FLG);
>>
>>
>>         cpm_load_patch(imp);
>> #endif
>>      .......
>>
>> In our case, CONFIG_UCODE_PATCH is not defined so the commproc is never
>> reseted during reboot. Could it be that the #ifdef CONFIG_UCODE_PATCH
>> should just be around the cpm_load_patch command?
>
>It seems the author wants to reset the cpm only when microcode
>patches are needed.
>
>m8260_cpm_reset() does also not reset the cpm.
>
>I don't know why (e.g. the console is setup after this)
>
>Jaap-Jan
>
>> The CONFIG_UCODE_PATCH seems to point this to be i2c/spi patch, but
>> shouldn't a reset go to cpm in anycase?
>>
>> /Per
>>
>>
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
