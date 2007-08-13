Return-Path: <domen.puncer@telargo.com>
Date: Mon, 13 Aug 2007 09:54:23 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: basic and stupid question on wait_event and wake_up
Message-ID: <20070813075423.GE13994@moe.telargo.com>
References: <BAY138-F25C6B0625737531B77D706B2E30@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <BAY138-F25C6B0625737531B77D706B2E30@phx.gbl>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 12/08/07 13:57 +0000, Ming Liu wrote:
> Dear all,
> I am reading LDD(V3) chapter 6 on the topic of wait_event(queue, conditio=
n)=20
> and wake_up(queue) functions. I am quite confused on the sayings. One is=
=20
> "Until condition evaluates to a true value, the process continues to=20
> sleep", which looks like that 'condition' is the one who wake up the=20
> process from its sleeping. However the other saying is "The basic functio=
n=20
> that wakes up sleeping processes is called wake_up, and wake_up wakes up=
=20
> all processes waiting on the given queue" So who is the exact one to wake=
=20
> the sleeping process up at all, condition or wake_up? From my=20
> understanding, if the condition becomes true, then the sleeping process=
=20
> will leave its sleeping status and wake up. Then what's the use of wake_u=
p=20
> function?=20

I understand it this way:
- condition
  Just checking the condition is one way (if you don't have a wake_up
  source, like an interrupt), but that's not really what wait_event does.
  It would be something like
	while (condition) {
		msleep(10);
	}
  There was some talk on poll_wait(), but I don't know what happened to
  it.

- wake_up
  Just wake_up isn't enough, you get a race:
  |   interrupt handler   |   process      |
  ------------------------------------------
  |   do_something()      |                |
  |   wake_up()           |                |
  |   ...                 |   wait on wq   |

  And so you have a process waiting on waitqueue, that just missed the
  wakeup. Obviously should not be used.

- wake_up & condition
  |   interrupt handler   |   process      |
  ------------------------------------------
  |   flag =3D 1            |                |
  |   wake_up()           |                |
  |   ...                 |   wait_event   |
  |   ...                 |   flag =3D 0     |

  This will work properly and if wait_event misses a wake_up, the
  condition check (flag)  will kick in before putting it to sleep.


>=20
> My senario could be described as: in my char device driver, I use one ioc=
tl=20
> command to initiate a DMA transfer. After all related registers are=20
> initiated, this process will be put to sleep for saving CPU cycles. In th=
e=20
> interrupt handler which is for a DMA_done, I wake that process up and=20
> resume its following executing. With this method, in my application progr=
am=20
> if I release a DMA initiation command, it is a Blocking operation and it=
=20
> will wait until the DMA transfer is done.=20

Looks like you should use the "wake_up and condition" option.


	Domen

>=20
> Perhaps my question is quite simple or basic. Thanks for any explanation=
=20
> and comment on this topic in my senario from you experts. Thanks a lot.
>=20
> Br
> Ming
>=20
> _________________________________________________________________
> =E4=B8=8E=E8=81=94=E6=9C=BA=E7=9A=84=E6=9C=8B=E5=8F=8B=E8=BF=9B=E8=A1=8C=
=E4=BA=A4=E6=B5=81=EF=BC=8C=E8=AF=B7=E4=BD=BF=E7=94=A8 MSN Messenger:  http=
://messenger.msn.com/cn =20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
