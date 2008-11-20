Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id A4B15DDDED
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 02:19:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: times(2) sys call bug?
Date: Thu, 20 Nov 2008 16:09:16 +0100
Message-ID: <1227193640.5224.90.camel@gentoo-jocke.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "linuxppc-dev Development" <linuxppc-dev@ozlabs.org>
Reply-To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Why does the below program end up reporting -1
multiple seconds when times() wrap:

#include <sys/times.h>
#include <stdio.h>

main()
{
        unsigned long t1;
        clock_t t2;
        while(1){
                t1 =3D times(NULL);
                t2 =3D times(NULL);
                sleep(1);
                printf("unsigned t1:%u, clock_t t2:%d\n", t1, t2);
                if (t2 > 1000)
                        break;
        }
}
and got:

unsigned t1:4294966339, clock_t t2:-957
unsigned t1:4294966439, clock_t t2:-857
unsigned t1:4294966539, clock_t t2:-757
unsigned t1:4294966639, clock_t t2:-657
unsigned t1:4294966739, clock_t t2:-557
unsigned t1:4294967295, clock_t t2:-1
unsigned t1:4294967295, clock_t t2:-1
unsigned t1:4294967295, clock_t t2:-1
unsigned t1:4294967295, clock_t t2:-1
unsigned t1:4294967295, clock_t t2:-1
unsigned t1:43, clock_t t2:43
unsigned t1:143, clock_t t2:143
unsigned t1:243, clock_t t2:243
unsigned t1:343, clock_t t2:343
unsigned t1:443, clock_t t2:443
unsigned t1:543, clock_t t2:543
unsigned t1:643, clock_t t2:643
unsigned t1:743, clock_t t2:743
unsigned t1:843, clock_t t2:843
unsigned t1:943, clock_t t2:943
unsigned t1:1043, clock_t t2:1043
