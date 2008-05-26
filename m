Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 832D1DDF28
	for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2008 04:21:51 +1000 (EST)
Received: from [192.168.1.37] (node178.77.251.72.1dial.com [72.251.77.178])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m4QILQv7094635
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 11:21:47 -0700 (PDT)
Message-ID: <483AFF9F.7090704@hypersurf.com>
Date: Mon, 26 May 2008 11:21:19 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: boot hang
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

	I am getting a boot hang right after a message something like:

console handover

I am trying to stop the reloading of HID1 out of nap:

--- idle_6xx-old_S      2008-02-25 18:10:30.000000000 -0800
+++ idle_6xx-new_S      2008-05-26 10:01:58.000000000 -0700
@@ -179,9 +179,15 @@
  1:
  END_FTR_SECTION_IFSET(CPU_FTR_NAP_DISABLE_L2_PR)
  BEGIN_FTR_SECTION
+       /* 750FX/GX CPU Freq support requires this be disabled */
+       lis     r9,powersave_nap_no_hid1@ha
+       lwz     r9,powersave_nap_no_hid1@l(r9)
+       cmpwi   0,r9,0
+       beq     1f
         addis   r9,r11,(nap_save_hid1-KERNELBASE)@ha
         lwz     r9,nap_save_hid1@l(r9)
         mtspr   SPRN_HID1, r9
+1:
  END_FTR_SECTION_IFSET(CPU_FTR_DUAL_PLL_750FX)
         b       transfer_to_handler_cont

@@ -195,3 +201,6 @@

  _GLOBAL(powersave_lowspeed)
         .long   0
+
+_GLOBAL(powersave_nap_no_hid1)
+       .long   0

I also added powersave_lowspeed and powersave_nap_no_hid1 to the end of 
ppc_ksyms.c.

Any suggestions would be appreciated.

kevin
