Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Improved copy_page() function, about 30% speed up for mpc860!
Date: Thu, 27 Feb 2003 16:45:30 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLGEKIFKAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <IGEFJKJNHJDCBKALBJLLOEKGFKAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Hi all
>
> I have been playing with the copy_page() function in arch/ppc/kernel/misc.S
> and gained about 30% speed up for my mpc860, rev D4 MHz.
>
> This is what i did:
> - Use dcbz on 8xx but clear ahead one cache line(performance is really crappy
>   if I don't clear ahead). This is the biggest improvement.
> - Use prefetch for 8xx as well.
>
> I know that dcbz is buggy for some 8xx CPUs but I don't know which ones.
> For me works just fine, except in copy_tofrom_user(don't know why).

hmm, I made two versions of copy_tofrom_user(), copy_from_user() and copy_to_user()
and modified asm/uaccess.h to reflect this.
Then I modified copy_from_user() to use dcbz on the destination area.
Booted and started our app and it works just fine!

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
