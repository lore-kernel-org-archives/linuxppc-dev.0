Return-Path: <wangbj@lzu.edu.cn>
Received: from eyou.net (gwmail.lzu.edu.cn [202.201.0.146])
	by ozlabs.org (Postfix) with SMTP id F2310DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Sep 2007 12:00:13 +1000 (EST)
Message-ID: <389019707.21991@eyou.net>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: disable interrput under ppc?
Date: Wed, 5 Sep 2007 10:00:46 +0800
References: <200709041044.16525.wangbj@lzu.edu.cn>
	<20070904182433.GD18280@ld0162-tx32.am.freescale.net>
	<388931546.05165@lzu.edu.cn>
In-Reply-To: <388931546.05165@lzu.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3406749.ngIpr4WM9b";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200709051000.46281.wangbj@lzu.edu.cn>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart3406749.ngIpr4WM9b
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 05 September 2007, you wrote:
> On Tue, 4 Sep 2007 13:24:33 -0500
>
> Scott Wood <scottwood@freescale.com> wrote:
> > On Tue, Sep 04, 2007 at 10:44:14AM +0800, Wang, Baojun wrote:
> > > hi, list
> > >
> > >   How can I disable interrput like `cli' in x86?
> >
> > local_irq_disable().
> >
> > > I want the following code freeze the box but it doesn't, $MSR is
> > > altered however the box is still alive, how can I freeze the box like
> > > `cli' in x86? Thanks very much!
> >
> > Disabling interrupts doesn't freeze the machine by itself -- it depends
> > on what you do afterwards, which you didn't show.
I need to check whether the interrupt have been disabled already, so I'm=20
expected after local_irq_disable() ( __asm__ __volatile__ ("wrteei=20
0": : :"memory) ), the machine is dead but it doesn't.
> If you're using a BOOKE variant, there is a way to use the DBCR0
> register to set debug wait enable or something to basically hang the
> CPU until something external clears that bit.  But why you would want
> to do that, I have no idea.
Sorry, I just want to check whether disable_irq/enable_irq is functioning.
> josh

I'm not really getting confused about the following code:

  // Executing all pending events
  while ((event =3D get_next_set_bit_and_clear
          (pending, xm_root_domain -> events -> masked_events)) !=3D -1) {
    // An event  pending when there  is not any  handler installed
    // catching it??? it must be an error
    //assert (xm_root_domain -> event_handler [event]);
    if (!xm_root_domain -> events -> event_handler [event]) continue;
      // Before executing an event handler, events' flag is disabled
      // and the event is masked

    printk(KERN_EMERG"sync_root_events: looping!\n");

    set_bit (xm_root_domain -> events -> masked_events, event);
    printk(KERN_EMERG"sync_root_events: looping 2!\n");
    disable_events_flag (xm_root_domain);
    printk(KERN_EMERG"sync_root_events: looping 3!\n");
    printk(KERN_EMERG"hw_irq_disabled?: %d\n", hw_irq_disabled());
    hw_enable_irq ();
    printk(KERN_EMERG"sync_root_events: looping 4!\n");
    // Here, the event handler is executed always
    // with the same conditions, that is, event flag disabled
    // and the executed event masked as well
    (*xm_root_domain -> events -> event_handler[event])
      (event, regs);
    printk(KERN_EMERG"sync_root_events: looping 5!\n");
    hw_disable_irq();
    printk(KERN_EMERG"sync_root_events: looping 6!\n");
    // Events flag is automatically enabled (iret emulation)
    enable_events_flag (xm_root_domain);
  }

hw_enable_irq() and hw_disable_irq() is exactly the same as=20
local_irq_enable()/local_irq_disable(), but the output shows while running=
=20
hw_eable_irq() (at that point irq is disabled), the rest of the code is=20
blocked, and I don't know why:

output:
[  172.049381] sync_root_events: looping!
[  172.053159] sync_root_events: looping 2!
[  172.057094] sync_root_events: looping 3!
[  172.061027] hw_irq_disabled?: 1
[  172.997338] sync_root_events: looping!
[  173.001095] sync_root_events: looping 2!
[  173.005028] sync_root_events: looping 3!
[  173.008961] hw_irq_disabled?: 1


I'm sorry If I'm asking a bad question, I'm not familiar with ppc/kernel=20
programming at this moment. Great thanks to Scott and josh for your reply.=
=20

  Regards,
Wang
=2D-=20
Wang, Baojun                                        Lanzhou University
Distributed & Embedded System Lab              http://dslab.lzu.edu.cn
School of Information Science and Engeneering        wangbj@lzu.edu.cn
Tianshui South Road 222. Lanzhou 730000                     .P.R.China
Tel:+86-931-8912025                                Fax:+86-931-8912022

--nextPart3406749.ngIpr4WM9b
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBG3g3OIuIOr7tpgg0RAlu4AJwM5RPWtscXud/zmSNztgdvTmAUnQCcCK6y
TTLJq7Un1O0WIvKPffh05+U=
=njrd
-----END PGP SIGNATURE-----

--nextPart3406749.ngIpr4WM9b--
