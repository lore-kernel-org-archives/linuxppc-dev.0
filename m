Return-Path: <scarayol@assystembrime.com>
Received: from srv_courtaboeuf.brime.fr (unknown [81.255.87.178])
	by ozlabs.org (Postfix) with ESMTP id AF90467A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 02:16:25 +1000 (EST)
To: akpm@osdl.org;
Message-ID: <OF255CB959.8F4DBEC4-ONC1256FE2.0023569C@brime.fr>
From: scarayol@assystembrime.com
Date: Wed, 13 Apr 2005 18:17:21 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: mmap : please help !
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I need somme help : I wrote driver like /dev/mem to read and write into=

physical memory at specific addresses. For that, I use instruction mmap=

like that :


    if((mem_mc_fd =3D open("/dev/map_mc",O_RDWR | O_SYNC)) < 0)
    {
        printf("\nProbleme pour ouvrir /dev/map_mc\n");
        exit(-1);
    }

 // mapping de la zone correspondante
    pmapMC =3D (DisqueMC *)mmap (0,MC_SIZE, PROT_READ | PROT_WRITE |
PROT_EXEC, MAP_SHARED, mem_mc_fd, MC_BASE_ADDRESS);
    if (pmapMC =3D=3D MAP_FAILED)
    {
        printf("Erreur de mmap pour MC:%d,%s\n",errno, strerror(errno))=
;
         close(mem_mc_fd);
 }

I use function pread, pwrite to access datas within the driver function=
s
but, I should prefer to use pmapMC pointer (by the mean of this virtual=

address) that points to a structure. I thought that it was the same to
access to the physical memory to use the pointer or to use read, write =
on
the file (by mem_mc_fd), but it seems to have different results. What i=
s
wrong ? What is the good manner to read or write in the physical memory=
?

Thanks a lot.

----------------------------------------------------------
Sophie CARAYOL

TECHNOLOGIES & SYSTEMES
50 rue du Pr=E9sident Sadate
F - 29337 QUIMPER CEDEX

T=E9l: +33 2 98 10 30 06
mailto:scarayol@assystembrime.com
----------------------------------------------------------
=
