Message-ID: <3E92F880.8080500@mvista.com>
Date: Tue, 08 Apr 2003 11:27:44 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Marius Groeger <mag@sysgo.de>
Cc: Erik Christiansen <erik@dd.nec.com.au>, Darin.Johnson@nokia.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc vs. newlib
References: <F0B628F30F48064289D8CCC1EE21B7A80C4869@mvebe001.americas.nokia.com> <3E8E31AD.3050302@mvista.com> <20030407014717.GA742@dd.nec.com.au> <3E911523.5050607@mvista.com> <Pine.LNX.4.52.0304081831450.3191@mag.devdep.sysgo.de>
In-Reply-To: <Pine.LNX.4.52.0304081831450.3191@mag.devdep.sysgo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marius Groeger wrote:
> On Mon, 7 Apr 2003, Mark Hatle wrote:
>
>
>>looks promising.  For a more traditional linux system, glibc is
>>truely the only way to do it.  (With special tools you can
>>dramatically reduce the size of glibc, but not as far as most people
>>would like.)
>
>
> This kind of size reduction (aka. "optimisation") sounds sort of scary
> to me. Glibc is a big and complicated beast (look, for instance, at
> the rather loose ties by which the libnss-stuff is held together). You
> seem to have some experience here. Can you seriously recommend this
> for _production_ software?

Absolutly.  The optimizations that are supported in both open source and by
companies like the one I work for (MontaVista Software) are pretty simple.
Specifically they re-link the shared library based on the requirements of the
rest of the files in the filesystem.

This linking occurs on the original *.o files that produced the original glibc.
  Internal and external glibc dependencies are fully resolved and the resulting
binary is as-if you built glibc and just #ifdef-ed out a lot of code...  (FYI
there are a few implicit glibc dependencies that have to be known by the tool
itself as they can't be gleamed from objdump.)

The key with this type of optimization though is that it is very specific to a
given filesystem.  Don't expect to add large chunks of functionality to an
existing filesystem, without first having to re-link glibc for any pieces that
may be missing.

As far as the libnss stuff goes, in reality it's rarely an issue for the systems
that need this type of optimization.  They don't have a true users/groups setup,
nor usually have internet connectivity (requiring DNS).  (At least that has been
my experience.)

So short answer, running a glibc "optimizer" which re-links the original glibc
.o files is absolutly safe and supportable.. you just have to understand what it
means and how it works to decide if it is right for your application.

--Mark
(Just as a note, I speak for myself and not my company when I write to these
lists... unless I specifically claim to be speaking for MontaVista)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
