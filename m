Return-Path: <alohanono@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.237])
	by ozlabs.org (Postfix) with ESMTP id 9476EDDF0C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Mar 2008 21:10:07 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so3028659wri.3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Mar 2008 03:10:06 -0700 (PDT)
Message-ID: <47EA20F9.8040703@gmail.com>
Date: Wed, 26 Mar 2008 11:10:01 +0100
From: "A. Nolson" <alohanono@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Getting CYPRESS CYC67300 (through opb_epc) and SystemAce to work
	in the ML403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

 I need to configure a system in a ML403 to make work the USB host 
(CYPRESS CYC67300) toguether with the  SystemAce core in my Linux 2.6.23 
( secretlab ) . By now I have everything succesfully running without the 
USB so I tried to follow the Xilinx Xapp925. Unfortunately, when looking 
into the BSS there is no use of SystemAce. In fact, when if I try to use 
the wizard to build a system from scratch, it argues that the Cypress 
controller and the SystemAce cannot be used at the same time since they 
share some resources.  When looking more deeply into the files in 
Xapp925, I have seen they include a simple IP core (glue logic) for some 
pin multiplexing, but they don't make use of it.
 
 The code itself is ( inside pcores/misc_logic_0_1.00.a/:

(...)
  always @(posedge clk)
    usb_ce_d1 <= usb_ce;

  // USB and SysAce Mux Logic
  assign usb_data_i = {sace_usb_d_I, 16'b0};
  assign sysace_mpd_i = sace_usb_d_I;
  assign sace_usb_a   = (usb_ce | usb_ce_d1)? 
{4'b0,usb_addr[28:29],1'b0} : sysace_mpa;
  assign sace_usb_d_O = (usb_ce | usb_ce_d1)? usb_data_o[0:15] : 
sysace_mpd_o;
  assign sace_usb_d_T = (usb_ce | usb_ce_d1)? usb_data_t[0:15] : 
sysace_mpd_t;
  assign sace_usb_oen = (usb_ce_d1)? usb_rdn : sysace_mpoe;
  assign sace_usb_wen = (usb_ce & usb_ce_d1)? usb_wrn : sysace_mpwe;

(...)

My questions are:

 1. Will I be able to have both of them working in the same system?
 2. Will the Linux drivers be able to cope with this "muxing"?
 3. Will I have a penalty in performance if I use it?

I think this a very interesting question which I could not find any info 
neither in this list or internet, but I suppose there must be many 
people in the siltation of needing both USB and SystemACE to work together.

 Thank you very much in advance,

/A
