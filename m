Date: Tue, 2 Nov 1999 13:01:08 -0500 (EST)
From: Elliot Lee <sopwith@redhat.com>
To: Eric Dorland <dorland@lords.com>
cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: esound for PPC
In-Reply-To: <19991011231039.A526@HSE-MTL-ppp4363.qc.sympatico.ca>
Message-ID: <Pine.LNX.4.10.9911021252090.32674-100000@lacrosse.corp.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 11 Oct 1999, Eric Dorland wrote:

> Which old set of patches? I've tried Elliot's 0.2.15 and it doesn't fix 
> the playing of 16bit sounds. BTW, you need a patch to be able to compile 
> Elliot's 0.2.15. It seems the configure file assumes that a ppc linux is 
> MkLinux, and uses its driver instead of OSS. It appears its MkLinux that has 
> the little-endian sound driver, not linuxppc. Anyway the attached patch 
> changes removes the MkLinux testing (I don't know how to tell the
> difference), and just uses OSS.

I've applied the configure.in change (configure itself is a generated
file, along with Makefile.in etc., so sending patches to these is
pointless :)

I skipped the esdplay.c/esdfile.c ones because I had other solutions (such
as removing that code entirely.

If you ever see any code doing a 'setvirtualbyteorder', that line probably
should probably just be nixed altogether. There is only one place that
ever needs doing, and that is inside libesd.

Anyways, I have put up
ftp://people.redhat.com/sopwith/esound-0.2.16.tar.gz - this will probably
become the final thing if you and other people have no problems with it.
It is not yet final, so don't go sticking it into public download dirs or
anything. :)

You will also want to make sure you have gnome-libs 1.0.53 (from October
GNOME) or newer, since I know there was an endianness fix in the 1.0.40
series.

Thanks,
-- Elliot
Do not meddle in the affairs of dragons,
for you are crunchy and good with ketchup. 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
