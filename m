Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0067.outbound.protection.outlook.com [104.47.33.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysQSX416MzDrb1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2017 04:23:39 +1100 (AEDT)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: ppc32: semctl fails
Date: Wed, 6 Dec 2017 17:23:33 +0000
Message-ID: <1512581010.8313.153.camel@infinera.com>
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

This test, taken from perl Configure, fails on my ppc32, should it?
  semctl IPC_STAT failed: errno =3D Bad Address=20
is what I get, kernel is 4.1.43

-----------------

#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/stat.h>
#ifndef S_IRUSR
#   ifdef S_IREAD
#define S_IRUSR S_IREAD
#define S_IWUSR S_IWRITE
#define S_IXUSR S_IEXEC
#   else
#define S_IRUSR 0400
#define S_IWUSR 0200
#define S_IXUSR 0100
#   endif
#   define S_IRGRP (S_IRUSR>>3)
#   define S_IWGRP (S_IWUSR>>3)
#   define S_IXGRP (S_IXUSR>>3)
#   define S_IROTH (S_IRUSR>>6)
#   define S_IWOTH (S_IWUSR>>6)
#   define S_IXOTH (S_IXUSR>>6)
#endif
#ifndef S_IRWXU
#   define S_IRWXU (S_IRUSR|S_IWUSR|S_IXUSR)
#   define S_IRWXG (S_IRGRP|S_IWGRP|S_IXGRP)
#   define S_IRWXO (S_IROTH|S_IWOTH|S_IXOTH)
#endif

#include <string.h>
#include <stdio.h>
#include <errno.h>
#ifndef errno
extern int errno;
#endif
int main() {
  int sem, st;
  struct semid_ds arg;

#if defined(IPC_PRIVATE) && defined(S_IRWXU) && defined(S_IRWXG) &&  define=
d(S_IRWXO) && defined(IPC_CREAT)
  sem =3D semget(IPC_PRIVATE, 1, S_IRWXU|S_IRWXG|S_IRWXO|IPC_CREAT);
  if (sem > -1) {
    #ifdef IPC_STAT
    st =3D semctl(sem, 0, IPC_STAT, &arg);
    if (st =3D=3D 0)
      printf("semid_ds\n");
    else
#endif /* IPC_STAT */
      printf("semctl IPC_STAT failed: errno =3D %s\n", strerror(errno));
    #ifdef IPC_RMID
    if (semctl(sem, 0, IPC_RMID, &arg) !=3D 0)
#endif /* IPC_RMID */
      printf("semctl IPC_RMID failed: errno =3D %d\n", errno);
  } else
#endif /* IPC_PRIVATE && ... */
    printf("semget failed: errno =3D %d\n", errno);

  return 0;
}=
