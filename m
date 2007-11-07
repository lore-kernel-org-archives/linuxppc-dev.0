Return-Path: <jonsmirl@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by ozlabs.org (Postfix) with ESMTP id 1F08ADDEEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Nov 2007 08:55:26 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1747609nzh
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 07 Nov 2007 13:55:25 -0800 (PST)
Message-ID: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>
Date: Wed, 7 Nov 2007 16:55:23 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: use of fsl, in lite5200b.dts in git current
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sometimes the fsl prefix is being used and sometimes it isn't. Look at
the two compatible strings. Which way is it going to be? Is
fsl,has-wdt right?

                mpc5200_pic: pic@500 {
                        // 5200 interrupts are encoded into two levels;
                        interrupt-controller;
                        #interrupt-cells = <3>;
                        device_type = "interrupt-controller";
                        compatible = "mpc5200b-pic","mpc5200-pic";
                        reg = <500 80>;
                };

                gpt@600 {       // General Purpose Timer
                        compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
                        cell-index = <0>;
                        reg = <600 10>;
                        interrupts = <1 9 0>;
                        interrupt-parent = <&mpc5200_pic>;
                        fsl,has-wdt;
                };
                rtc@800 {       // Real time clock
                        compatible = "mpc5200b-rtc","mpc5200-rtc";
                        device_type = "rtc";
                        reg = <800 100>;
                        interrupts = <1 5 0 1 6 0>;
                        interrupt-parent = <&mpc5200_pic>;
                };



-- 
Jon Smirl
jonsmirl@gmail.com
