Subject: bug in asm-ppc/div64.h
From: Bastien Nocera <bnocera@redhat.com>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: multipart/mixed; boundary="=-VvFo6wGorFZdo3Ej5e4O"
Date: 11 Mar 2003 11:03:33 +0000
Message-Id: <1047380614.5038.7880.camel@bnocera.surrey.redhat.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-VvFo6wGorFZdo3Ej5e4O
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

While chasing a date bug in smbfs with Urban Widmark, it so happened
that we stumbled across a bug in do_div on PPC 32bit, ie. it doesn't
work.

I attached a test case, provided by Urban. do_div is used in quite a few
places like vsprintf, the matrox fb code, etc.

When running on x86:
now: 1047238073
adjusted: 24edd64059e100
/ 10000000: 3df4e80a
1039460362

Check the run on PPC. It's wrong by quite a scale.

Any ideas on how to solve this properly ?

Cheers

--
/Bastien Nocera
http://www.redhat.com

Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away.
                                                Antoine de Saint-Exupery

--=-VvFo6wGorFZdo3Ej5e4O
Content-Disposition: attachment; filename=smbfs-time.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=smbfs-time.c; charset=ISO-8859-1

#include <stdio.h>
#include <time.h>
#include <asm/types.h>
#include <asm/div64.h>

typedef  __u64 u64;

#define NTFS_TIME_OFFSET ((u64)(369*365 + 89) * 24 * 3600 * 10000000)

static time_t
smb_ntutc2unixutc(u64 ntutc)
{
	u64 t =3D ntutc - NTFS_TIME_OFFSET;
	printf("adjusted: %Lx\n", t);

	do_div(t, 10000000);
	printf("/ 10000000: %Lx\n", t);

	return (time_t)t;
}

int main()
{
    time_t t;

    t =3D time(NULL);
    printf("now: %ld\n", t);

    t =3D smb_ntutc2unixutc(0x01c29fb515986100LL);
    printf("%ld\n", t);
}

--=-VvFo6wGorFZdo3Ej5e4O--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
