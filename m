Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Santosh Kumar <santoshkumar.a@gmail.com>
Subject: Re: powerpc 476, Little-endian, pte fault
In-reply-to: <CAJw04pAh5QDQMkUHbj9=rRPiUCZejimHiydCJFMAoZeSd_ydhA@mail.gmail.com>
References: <CAJw04pD24W_nGSLheWunCa_o7QqBmRf_TSAD44EkzazigRe_nQ@mail.gmail.com>
 <12144.1320040276@neuling.org>
 <CAJw04pAh5QDQMkUHbj9=rRPiUCZejimHiydCJFMAoZeSd_ydhA@mail.gmail.com>
Date: Mon, 31 Oct 2011 20:49:48 +1100
Message-ID: <20440.1320054588@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Ian Munsie <ianmunsi@au1.ibm.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I have built a cross compiler for ppc440 in little endian mode and
> using it to build the kernel.
> 
> Yes i am running Linux in Little-Endian. This is the first user space
> process. I wrote the below program and running it as init from
> /sbin/init. I have also set the permissions with chmod +s.
> 
> main()
> {
> 
> while(1){
> printf("hello world");
> sleep(1);
>  }
> }

Does libc even support little endian on PPC?

> I have attached the patch.

This is a pretty huge patch:

 115 files changed, 44479 insertions(+), 7398 deletions(-)

It seems to include a new platform as well as a bunch of unrelated junk.

I suggest you need to break this down into something more digestible.
Like remove all the junk in the patch.  Then add the support for the new
platform (invader? platform).  Then start looking at little endian.
Unless you do this, it's unlikely anyone here is going to be able to
help.

When you get to the little endian work, you might want to take a look at
this patch series from Ian Munsie:

http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-October/086165.html

Mikey
