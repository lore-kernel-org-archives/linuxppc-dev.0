Message-ID: <398B8ACA.F11EE7F6@mvista.com>
Date: Fri, 04 Aug 2000 20:32:26 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Kwansuk Kim <kskim@neowave.co.kr>
CC: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>, frowand@mvista.com
Subject: Re: Compiling apache for Linux PPC
References: <NEBBKFENMLEDKDHMEHPJEEBPCBAA.kskim@neowave.co.kr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kwansuk Kim wrote:
>
> I'm trying to implement embedded linux router.
>
> So I tried to cross-compile apache on x86 linux machine.
>
> I changed the compiler name from 'gcc' to 'powerpc-linux-gcc'
>
> But when I ran make there was an error. Of course compile with gcc, it works well.
>
> Is there any options? It seems there is no use of configure option '--tartget=powerpc-linux'
>

A few hints...


./configure --prefix=YOUR_INSTALL_PATH

make

cd src/main

copy gen_test_char and gen_uri_delims to your target (PowerPC) system

run gen_test_char and gen_uri_delims on your target system

copy the output of gen_test_char to test_char.h on your host system

copy the output of gen_uri_delims to uri_delims.h on your host system

cd -

make

*** I may not have the syntax exactly right on the next command, but it
gives you the idea:

find -name "*\.a" -exec \
  /opt/hardhat/devkit/ppc/8xx/bin/powerpc-linux-ranlib {} \;

make

make install



-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
