Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D770C2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2013 13:52:35 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 3 Jun 2013 21:52:32 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 9D3AA3E4004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2013 21:52:13 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r543qRT8091564
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jun 2013 21:52:27 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r543qUDw029456
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jun 2013 21:52:30 -0600
Date: Tue, 4 Jun 2013 11:52:23 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Robert Knight <knight@princeton.edu>,
 Brian King <brking@linux.vnet.ibm.com>,
 Wendy Xiong <wenxiong@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: IBM OpenPower 720 ipr driver woes
Message-ID: <20130604035223.GA27964@shangw.(null)>
References: <51A61B82.5050508@princeton.edu>
 <51A644C2.5090300@linux.vnet.ibm.com>
 <51AD088C.8040803@princeton.edu>
 <20130604000130.GA25055@thor.bakeyournoodle.com>
 <51AD45A4.9080702@princeton.edu>
 <20130604031651.GA3373@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
In-Reply-To: <20130604031651.GA3373@thor.bakeyournoodle.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 04, 2013 at 01:16:52PM +1000, Tony Breeds wrote:
>On Mon, Jun 03, 2013 at 09:40:52PM -0400, Robert Knight wrote:
>> On 6/3/2013 8:01 PM, Tony Breeds wrote:
>> >On Mon, Jun 03, 2013 at 05:20:12PM -0400, Robert Knight wrote:
>> >
>> >>>Device tree struct  0x0000000004820000 -> 0x0000000004840000
>> >>>Calling quiesce...
>> >>>returning from prom_init
>> >>>[    1.376359] ehci-pci 0000:c8:01.2: can't setup
>> >Can you try adding "debug" to the kernel commandline.  We're missing a
>> >great chunk of detail. If you're starting from scratch either try F18 or
>> >the F19 Beta (if you're brave :))
>> >
>> >Yours Tony
>> So, two points.  Since I have no live disks, I can't copy the dmesg
>> output in dracut onto a disk and just sent it to you -- the only way
>> that I know to get it is cut and paste from a HMC console window
>> into a vi buffer.
>
>Okay, when I've been in that situation, I run "script" locally and then
>conenct to the HMC console.
>
>When you're done you can exit script adn then a file called typescript
>will exist in the directory you ran script in.
>
>It's a less overhead way of doign what you're already doing.
> [    0.087097] NET: Registered protocol family 16
>
>> [    0.087144] pseries_eeh_init: RTAS service <ibm,get-config-addr-info2> and <i
>> bm,get-config-addr-info> invalid
>> [    0.087155] eeh_init: Failed to call platform init function (-22)
>
>Hmm this seems pretty strange to me.  Gavin are these RTAS tokens
>supported on older power5 boxes?
>

Yes, Tony. "ibm,get-config-addr-info" should be supported on Power5 box.
Newer PowerBox (e.g. P7) should support "ibm,get-config-addr-info2"

Please have a try on the attached patch, which is based on mainline (3.10).

Thanks,
Gavin



--1yeeQ81UyVL57Vl7
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-powerpc-eeh-Don-t-check-RTAS-token-to-get-PE-addr.patch"

>From 04771628d53e1e6883063ed21bd6825ee9680366 Mon Sep 17 00:00:00 2001
From: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue, 4 Jun 2013 11:47:59 +0800
Subject: [PATCH] powerpc/eeh: Don't check RTAS token to get PE addr

RTAS token "ibm,get-config-addr-info" or ibm,get-config-addr-info2"
are used to retrieve the PE address according to PCI address, which
made up of domain/bus/slot/function. If we don't have those 2 tokens,
the domain/bus/slot/function would be used as the address for EEH
RTAS operations. Some older f/w might not have those 2 tokens and
that blocks the EEH functionality to be initialized.

The patch skips the check on those 2 tokens so we can bring up EEH
functionality successfully. And domain/bus/slot/function will be
used as address for EEH RTAS operations.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 19506f9..b456b15 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -83,7 +83,11 @@ static int pseries_eeh_init(void)
 	ibm_configure_pe		= rtas_token("ibm,configure-pe");
 	ibm_configure_bridge		= rtas_token("ibm,configure-bridge");
 
-	/* necessary sanity check */
+	/*
+	 * Necessary sanity check. We needn't check "get-config-addr-info"
+	 * and its variant since the old firmware probably support address
+	 * of domain/bus/slot/function for EEH RTAS operations.
+	 */
 	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE) {
 		pr_warning("%s: RTAS service <ibm,set-eeh-option> invalid\n",
 			__func__);
@@ -102,12 +106,6 @@ static int pseries_eeh_init(void)
 		pr_warning("%s: RTAS service <ibm,slot-error-detail> invalid\n",
 			__func__);
 		return -EINVAL;
-	} else if (ibm_get_config_addr_info2 == RTAS_UNKNOWN_SERVICE &&
-		   ibm_get_config_addr_info == RTAS_UNKNOWN_SERVICE) {
-		pr_warning("%s: RTAS service <ibm,get-config-addr-info2> and "
-			"<ibm,get-config-addr-info> invalid\n",
-			__func__);
-		return -EINVAL;
 	} else if (ibm_configure_pe == RTAS_UNKNOWN_SERVICE &&
 		   ibm_configure_bridge == RTAS_UNKNOWN_SERVICE) {
 		pr_warning("%s: RTAS service <ibm,configure-pe> and "
-- 
1.7.5.4


--1yeeQ81UyVL57Vl7--
