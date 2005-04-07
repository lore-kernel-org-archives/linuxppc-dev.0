Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 56CDD67B15
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 20:23:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 7 Apr 2005 12:23:14 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B1B@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Interrupt disabling design
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody,=20
I'm trying to emulate a VxWorks-designed application under a linux =
montavista environment.
In this application I have critical portion of code which need the =
interrupts disabled as below:

-------------------------------------
  lockKey =3D OSIntrLock();some=20
    .
    . // my critical code =20
    .
  bsos1IntrUnlock(lockKey);
-------------------------------------
As you can see we use an OS encapsulation layer which is used to call =
the OS routines:

----------------------------
int OSIntrLock(void)
{
  return (intLock());  // vxWorks routine
}

void OSIntrUnlock(int lockKey)
{
  intUnlock(lockKey);  // vxWorks routine
}
----------------------------

Furthermore, I'm running my "VxWorks emulator" in the user-space and I'm =
not allowed to modify files others than the OS encapsulation layer ones.
So, how can I use the "cli() / sti()" functions from the user space as =
below:


 | USER-SPACE   |  --> | KERNEL-SPACE |  --> |    USER-SPACE    | --> | =
KERNEL-SPACE |  --> | USER-SPACE |
 |              |      |              |      |                  |     |  =
            |      |            |        =20
 | OSIntrLock() |      |   cli()      |      | my critical code |     |  =
  sti()     |      |   .....    |
                                             |  OSIntrUnlock()  |   =20

Is it possible to do that? Cause If I do a "cli()" call, I disable =
interrupts --> so, will the "sti()" call work?
If yes, it allows me to make my own system call to use them from the =
user space but I'm not really sure...

Tks a lot for your help=20
