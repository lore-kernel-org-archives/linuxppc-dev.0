Date: Fri, 17 Oct 2003 09:33:09 +0200
Message-ID: <3F710B1D00088333@mssbzhh-int.msg.bluewin.ch>
In-Reply-To: <1066374939.735.45.camel@toni>
From: "Wolfgang Grandegger" <wolfgang.grandegger@bluewin.ch>
Subject: RE: Doing floating point calculations in kernel space
To: t.vanremortel@ha.be,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

this has been discussed recently. For RTAI on MPC 8xx we
provide the following example:

 ftp://ftp.denx.de/pub/RTAI/contrib/fp_ppc_8xx.tar.bz2

It links statically with the libm and the soft-float
library derived from libgcc.

Hope it's useful.



>-- Original Message --
>Subject: Doing floating point calculations in kernel space
>From: Toni Van Remortel <t.vanremortel@ha.be>
>Reply-To: t.vanremortel@ha.be
>To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
>Date: Fri, 17 Oct 2003 09:15:39 +0200
>
>
>
>Hi all,
>
>When I thought it was a /proc problem, it was a float problem.
>The CPU (405GP) has no FPU, but I need to calculate sin and cos in a
>kernel module.
>Why? Well, we use a formula to draw figures (all deformed circles).
>Those figures can be defined with only 6 parameters, which are passed
>from the control-panel (in userspace) to the RTAI-powered kernel module.
>That module calculates the X and Y positions, creates PWM signals from
>it and outputs them to GPIO1 and 2.
>
>I don't see another approach to get this working, because the
>control-panel isn't real time, while the kernel module is. So the module
>needs to calculate the X and Y positions from the 6 parameters.
>
>To make it short: can I use floating points in kernel space? The info
>I've found just tells me 'no', but I'm wondering if there are any
>workarounds for this.
>I did find some 'faster math functions' which don't require any sin or
>cos anymore, but they do require floating points.
>
>A possible solution to me, is using 'unsinged long int' multiplied by
>some factor of 10.
>
>Anybody a better solution?
>
>PS: might be a bit off topic here, sorry about that.
>--
>                           Toni Van Remortel
>              Wetenschappelijk Medewerker - D-science lab
>  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
>              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
>                      E-mail: t.vanremortel@ha.be
>
>
>


Wolfgang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
