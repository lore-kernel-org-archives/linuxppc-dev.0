Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0B3A9B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 23:48:00 +1100 (EST)
Received: by vcbfl15 with SMTP id fl15so341587vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Dec 2011 04:47:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EDF5ED7.2030709@in.ibm.com>
References: <20111114053749.23410.63745.stgit@suzukikp.in.ibm.com>
 <20111114054144.23410.65704.stgit@suzukikp.in.ibm.com>
 <CA+5PVA6uVpB6XUFkjUABJCcVjubFiWWEQgmuMijTQpdAiN7PdQ@mail.gmail.com>
 <4ED4126D.7000201@freescale.com>
 <CA+5PVA7r215N3NZV9gaTiXzeiwBnPBMbssX0Qo3zJ-9eGJaypA@mail.gmail.com>
 <4EDF5ED7.2030709@in.ibm.com>
Date: Wed, 7 Dec 2011 07:47:56 -0500
Message-ID: <CA+5PVA44WNwg9pLLq6E_RudbTzW0e-_sv9aK-BzP_iRE5t_b7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] [booke] Rename mapping based RELOCATABLE to
 DYNAMIC_MEMSTART for BookE
From: Josh Boyer <jwboyer@gmail.com>
To: Suzuki Poulose <suzuki@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
 Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 David Laight <David.Laight@aculab.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 7, 2011 at 7:40 AM, Suzuki Poulose <suzuki@in.ibm.com> wrote:
> Josh,
>
> I rebased my patches to 3.2.0-rc3 and was able to verify it on my QEMU
> setup.
> However I am facing problems getting the my boards booted with the network
> cards
> (even without the patches). Here is what I see :
>
>
> Creating 2 MTD partitions on "1ff800000.large-flash":
> 0x000000000000-0x000000380000 : "fs"
> 0x000000380000-0x000000400000 : "firmware"
> PPC 4xx OCP EMAC driver, version 3.54
> mal0: failed to map interrupts !

That's the problem.

There was a bogus commit that was added to the generic OF code that
prevented the normal mapping that the MAL nodes do from working.  It
was later reverted after Benh told Linus it was bogus.  I don't
remember which -rc that wound up in, but if you move to 3.2-rc4 that
should help.

josh
