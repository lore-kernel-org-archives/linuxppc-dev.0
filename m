Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "'Wolfgang Denk'" <wd@denx.de>,
	"'Demke, Torsten'" <Torsten.Demke@fci.com>
Cc: "'Linuxppc-Embedded (E-mail)'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: problem with standard libc on 8xx 
Date: Fri, 27 Feb 2004 11:18:33 +0100
Message-ID: <006301c3fd1b$0e58a2a0$0a01a8c0@LUMENTIS02>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20040227094329.89EFCC0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> In message
> <9CFB9DA5261CD611A29B00508B78904807F880ED@ex-deu-munich02.forc
> e.de> you wrote:
> >
> > I created my own root-fs for a MPC8xx platform
> > using standard Debian packages (including libc).
> > When I start the system, the init scripts hangs
> ...
> > I guess that the Debian libc uses floating point - which
>
> Thi sis definitely one cause of the problem.  Another  one  might  be
> optimization  for  a  incorrect  cache  line  size  (32 instead of 16
> bytes).

Also, you must make sure you don't use any cache instructions such
as dcbz. I believe the optimized memset function i glibc uses dcbz.

The mpc8xx CPU has a HW bug which makes the TLB exceptions fail
for most cache instructions. There is a workaround for this, but it
is somewhat ugly. Search the embedded archives if you want to known more.

   Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
