Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "aun.it.uu.se",
	Issuer "Uppsala University CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 722ED67B6F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 19:13:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17653.21437.207484.526897@alkaid.it.uu.se>
Date: Wed, 30 Aug 2006 11:00:45 +0200
From: Mikael Pettersson <mikpe@it.uu.se>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Linux v2.6.18-rc5
In-Reply-To: <17653.11388.637189.113422@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	<20060829115537.GA24256@aepfle.de>
	<20060829130629.GW11309@localdomain>
	<20060829155216.GA25861@aepfle.de>
	<17653.11388.637189.113422@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	Nathan Lynch <ntl@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras writes:
 > Olaf,
 > 
 > This patch should fix it.  The problem was that I was comparing a
 > 32-bit quantity with a 64-bit quantity, and consequently time wasn't
 > advancing.  This makes us use a 64-bit quantity on all platforms,
 > which ends up simplifying the code since we can now get rid of the
 > tb_last_stamp variable (which actually fixes another bug that Ben H
 > and I noticed while going carefully through the code).
 > 
 > This works fine on my G4 tibook.  Let me know how it goes on your
 > machines.

Thanks. This fixed a kernel hang bug on my G4 eMac with 2.6.18-rc5.

The vanilla kernel ran fine until I tar xvf'd a file from an NFS-mount,
then everything ground to a halt.

/Mikael
