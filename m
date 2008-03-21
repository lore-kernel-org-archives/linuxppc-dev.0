Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E9661DDE1A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 17:30:56 +1100 (EST)
Message-ID: <47E3561B.6040505@grandegger.com>
Date: Fri, 21 Mar 2008 07:30:51 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Bartlomiej Sieka <tur@semihalf.com>
Subject: Re: Oops with TQM5200 on TQM5200
References: <47E2723D.1090101@grandegger.com>
	<47E281B6.20702@denx.de>	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>
	<47E2FC3E.1020705@semihalf.com>
In-Reply-To: <47E2FC3E.1020705@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bartlomiej Sieka wrote:
> Grant Likely wrote:
>> Paul, my git server is down at the moment.  Can you please pick this
>> one up for .25?  It is needed to boot the tqm5200 board.
> 
> Could we also have similar fixes for cm5200.dts and motionpro.dts picked
> up? I could provide the patches within a day -- will this be OK?

At that occasion, could you please also add two CAN nodes to tqm5200.dts
as shown:

s$ diff -u tqm5200.dts tqm5200.dts.CAN
--- tqm5200.dts 2008-03-20 18:44:40.000000000 +0100
+++ tqm5200.dts.CAN     2008-03-21 07:27:49.000000000 +0100
@@ -68,6 +68,22 @@
                        fsl,has-wdt;
                };

+               can@900 {
+                       compatible = "fsl,mpc5200-mscan";
+                       cell-index = <0>;
+                       interrupts = <2 11 0>;
+                       interrupt-parent = <&mpc5200_pic>;
+                       reg = <900 80>;
+               };
+
+               can@980 {
+                       compatible = "fsl,mpc5200-mscan";
+                       cell-index = <1>;
+                       interrupts = <2 12 0>;
+                       interrupt-parent = <&mpc5200_pic>;
+                       reg = <980 80>;
+               };
+
                gpio@b00 {
                        compatible = "fsl,mpc5200-gpio";
                        reg = <b00 40>;

Thanks a lot.

Wolfgang.
