Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0044.outbound.protection.outlook.com [104.47.37.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysb6X2hdZzDrKp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2017 10:53:39 +1100 (AEDT)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "schwab@linux-m68k.org" <schwab@linux-m68k.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: ppc32: semctl fails
Date: Wed, 6 Dec 2017 23:53:33 +0000
Message-ID: <1512604410.8313.159.camel@infinera.com>
References: <1512581010.8313.153.camel__41464.7176782184$1512581316$gmane$org@infinera.com>
 <87lgif31q1.fsf@linux-m68k.org>
In-Reply-To: <87lgif31q1.fsf@linux-m68k.org>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-12-06 at 23:56 +0100, Andreas Schwab wrote:
>=20
> On Dez 06 2017, Joakim Tjernlund <Joakim.Tjernlund@infinera.com> wrote:
>=20
> >     st =3D semctl(sem, 0, IPC_STAT, &arg);
>=20
> This is not a valid use of IPC_STAT.  The fourth argument must be a
> object of type union semun (not a pointer), with the .buf member
> pointing to the struct semid_ds object.

Ahh, so perl had it wrong (Any perl guys here?). This is what I came up wit=
h and it works:

struct semid_ds arg;
  union semun {
    int              val;    /* Value for SETVAL */
    struct semid_ds *buf;    /* Buffer for IPC_STAT, IPC_SET */
    unsigned short  *array;  /* Array for GETALL, SETALL */
    struct seminfo  *__buf;  /* Buffer for IPC_INFO                        =
                                                               =20
                                (Linux-specific) */
  } semopts =3D {0};
  semopts.buf =3D &arg;

#if defined(IPC_PRIVATE) && defined(S_IRWXU) && defined(S_IRWXG) &&  define=
d(S_IRWXO) && defined(IPC_CREAT)
  sem =3D semget(IPC_PRIVATE, 1, S_IRWXU|S_IRWXG|S_IRWXO|IPC_CREAT);
  if (sem > -1) {
    #ifdef IPC_STAT
    st =3D semctl(sem, 0, IPC_STAT, semopts);
    if (st =3D=3D 0)
      printf("semid_ds\n");
    else
#endif /* IPC_STAT */
      printf("semctl IPC_STAT failed: errno =3D %s\n", strerror(errno));
    #ifdef IPC_RMID
    if (semctl(sem, 0, IPC_RMID, semopts) !=3D 0)
#endif /* IPC_RMID */
      printf("semctl IPC_RMID failed: errno =3D %d\n", errno);
  } else
#endif /* IPC_PRIVATE && ... */
    printf("semget failed: errno =3D %d\n", errno);
  return 0;

 Jocke=
