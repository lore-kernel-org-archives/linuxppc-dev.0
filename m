Return-Path: <bgat@billgatliff.com>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 5798FB7BF5
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Dec 2009 16:37:45 +1100 (EST)
Received: by yxe8 with SMTP id 8so8397603yxe.17
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 21:37:43 -0800 (PST)
Message-ID: <4B32FE43.1030905@billgatliff.com>
Date: Wed, 23 Dec 2009 23:38:11 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Does gpio_to_irq() work for MPC52xx gpios?
References: <4B312EDA.7030606@billgatliff.com>
	<87fx72wwpd.fsf@macbook.be.48ers.dk>
	<4B3249AA.50405@billgatliff.com> <4B327FEC.9030801@billgatliff.com>
In-Reply-To: <4B327FEC.9030801@billgatliff.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guys:


Ok, I have gpio_to_irq() more-or-less showing signs of life for the
MPC5200.  But I'm having some trouble using it the way I want to.

Recall that I have a rotary encoder that's tied to IRQ2 and
GPIO_WKUP_7.  I want to be able to describe it something like this:

    rotary-encoder {
        compatible = "linux,rotary-encoder","rotary-encoder";
        interrupts = <&mpc5200_pic 2 3 &gpio_wkup 0 1>; // "IRQ2 on the
MPC5200 PIC,
                                                                                               
// and pin 0 on GPIO_WKUP"
        type = <1>; // what event signal to generate
        val-ccw = <0x4a>; // what code to use for counter-clockwise rotation
        val-cw = <78>; // what code to use for clockwise rotation
    };

I've had some limited success with this, but not for any good reason. 
It turns out that the explanation for why I was getting a valid number
for the first interrupt specification was because the device tree
compiler was assuming that the interrupt-parent was the mpc5200_pic; my
reference to the node in that list was utterly meaningless.  The dtc
also appears to have ignored the &gpio_wkup word, and interpreted the
following zero as being the zero-th interrupt channel in the
mpc5200_pic.  Or something like that.  Clearly, I don't understand the
device tree syntax at all yet.

Anyway, when I change the statement to this:

    rotary-encoder {
        compatible = "linux,rotary-encoder","rotary-encoder";
        interrupt-parent = <&gpio_wkup>;
        interrupts = <0 0>;
        type = <1>;
        val-ccw = <0x4a>;
        val-cw = <78>;
        };

... then the magic number that the dtc comes up with is causing my new
chained interrupt handler for the gpio_wkup peripheral to come alive. 
(Of course it doesn't actually work yet, but that's not the point!)

So here's my question: does the device tree compiler/syntax limit you to
only one interrupt parent?

I think the answer is no, because what I'm trying to do doesn't seem
that much different from how one specifies GPIO pins coming from
different controllers.

Any suggestions?


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
