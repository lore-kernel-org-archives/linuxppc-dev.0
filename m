Date: Fri, 11 Apr 2003 16:38:31 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: kernel/timer.c
In-reply-to: <3E96C07B.4060809@dgt-lab.com.pl>
To: Wojciech Kromer <krom@dgt-lab.com.pl>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLEEPEFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-2
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Anyone knows why tehere is a line:
>
> expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
>
> in kernel/timer.c sys_nanosleep
> It adds additional time tick to expire. If anyone uses small HZ value
> (eg 100 which is default for arch-ppc) this causes aditional 10ms delay
> when calling nanosleep.

Yes, after a quick scan it looks like a bug to me. Anyone else?

>
>
> For me ( found by Andrzej Kass)
>  it should be:
>
> expire = timespec_to_jiffies(&t) + !(t.tv_sec || t.tv_nsec);
>    //^^add extra tick if there is
>   // nothing in tv_sec and nothing in tv_nsec

hmm, why not just:
   expire = timespec_to_jiffies(&t);
if tv_sec and tv_sec are zero, do you need to sleep at all?

    Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
