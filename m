In-Reply-To: <199912281902.OAA25964@mal-ach.watson.ibm.com>
Date: Tue, 28 Dec 1999 22:22:29 +0100
To: David Edelsohn <dje@watson.ibm.com>, dhd@debian.org,
        linuxppc-dev@lists.linuxppc.org
From: BenH <bh40@calva.net>
Subject: Re: DB_THREAD support in Berkeley DB/glibc
Message-Id: <19991228222229.008118@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Dec 28, 1999, David Edelsohn <dje@watson.ibm.com> wrote:

>	The TSL_SET macro is basically correct for PowerPC uniprocessor,
>but it is not MP safe.  For cases where this needs to be safe across a
>multiprocessor complex, it should be preceded by a "sync" instruction and
>ended with an "isync" instruction, or something similar depending on the
>semantics one uses for accessing the word.

Also, according to some Moto writing I read some time ago, the
reservation should be cleared in both the good case and the fail case.
Basically, once the lwarx was done, the stwcx. should be done even if
results don't match. The suggested implementation, if I recall correctly,
is to first do a normal load and compare, and if it matches, then enter
the lwarx/stwcx. pair.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
