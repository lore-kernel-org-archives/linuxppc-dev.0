Message-ID: <3C81AFE6.CDE1010D@mvista.com>
Date: Sat, 02 Mar 2002 23:08:54 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Jon-Erling Dahl <jon-erling.dahl@its4mobility.com>
Cc: Michael Habermann <MHabermann@gmx.de>,
	"'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: libraryopt
References: <GKEKJGELJKLLBBAFIGAIMEKACAAA.jon-erling.dahl@its4mobility.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jon-Erling Dahl wrote:
> files as input. My build script didn't get any object files at
> all and I think its because of this:
>
> I have an application 'myapp' that depends on a shared library
> 'mylib'. 'mylib' in turn depends on 'somelib', like this:
>
> myapp -> mylib -> somelib -> libc, libstdc++, etc
>
> What I tried was to create an optimizer for somelib. But since
> myapp doesn't depend on somelib directly, it seems that libopt
> doesn't think any of the object files in 'somelib' is needed,
> and hence no object files as input to the build script.
> Is this correct? Does libopt only work when an application is
> linked directly against the lib you're trying to optimize?
> Am I completely missing something here?
> I built an optimizer for 'mylib', and it worked correctly...

How did you link your app and the various libraries involved?  If you
used ld and did not specify the required libs, then the information
would not have gotten embedded into the elf information for each
required object.  If the elf information isn't there (or correct) the
library optimizer will be unable to correctly discover the link chain.
(You can use ldd or cross-ldd w/ hardhat linux to identify the required
libraries as listed in the elf information.)

When building software you should always use gcc to both compile and
link the software.  That is the only way to ensure that you get proper
library information, especially libc and libstdc++.  (In most cases you
can just replace ld w/ gcc, but for some apps you may have to throw in
some special gcc options.)

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
