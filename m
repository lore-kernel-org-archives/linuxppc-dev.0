Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f175.google.com (mail-gx0-f175.google.com
	[209.85.217.175]) by ozlabs.org (Postfix) with ESMTP id 3CF3ADDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 08:39:46 +1100 (EST)
Received: by gxk23 with SMTP id 23so655284gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 13:39:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9e4733910903061329n202725edibb8af1b979920d5b@mail.gmail.com>
References: <20090306211123.24316.80764.stgit@localhost.localdomain>
	<9e4733910903061329n202725edibb8af1b979920d5b@mail.gmail.com>
Date: Fri, 6 Mar 2009 14:39:45 -0700
Message-ID: <fa686aa40903061339w63dd2b75n1fb40f890f2ae54e@mail.gmail.com>
Subject: Re: [RFC 1/2] powerpc/5200: add general purpose timer API for the
	MPC5200
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 6, 2009 at 2:29 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> I'm using a GPT pin in input capture mode to implement IR. I attached
> my GPT driver code. I can convert to your API. That's a really cheap
> way to do IR, just IR sensor, resistor and a cap.

The driver I posted can't do input capture mode yet, but it shouldn't
be too difficult to add.  Just another api function for setting the
mode I think.  I don't have a use for that yet, so I haven't thought
much about it.  Feel free to suggest what you think the API should
look like.

> This is my old device tree, what should the new one look like?
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ir0@670 { /* General Purpose Timer 6 in In=
put mode */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "gpt-ir";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cell-index =3D <7>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x670 0x10>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <0x1 0x10 0=
x0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&mpc=
5200_pic>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};

You'd want a node for the IR device which uses the GPT node as its
interrupt controller.

so:
    gpt7: gpt@670 {
        compatible =3D "fsl,mpc5200b-gpt"
        reg =3D <0x670 0x10>;
        interrupt =3D <1 16 0>;
        interrupt-controller;
        #interrupt-cells =3D <1>;
    };

Then elsewhere:
    ir {
        compatible =3D "digispeaker,ir";  // or whatever best matches your =
board
        interrupt-parent =3D <&gpt>;
        interrupts =3D <0>;  // IIRC, '0' means irq on both edges for
the GPT irq controller
    };

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
