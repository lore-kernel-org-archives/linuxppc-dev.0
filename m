From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Eric Ding <ericding@applix.com>
Subject: Re: ld bug with -Bsymbolic --noinhibit-exec (2.9.1.0.990418-1c)
Date: Thu, 17 Jun 1999 23:24:58 +0200
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <199906162114.RAA11468@tuxedo.applix.com>
MIME-Version: 1.0
Message-Id: <99061723274300.01016@ns1102.munich.netsurf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Mit, 16 Jun 1999 schrieb Eric Ding:
>>>>>> Franz Sirl <Franz.Sirl-kernel@lauterbach.com> writes:
>
>> Hmm, I browsed thru the binutils code and didn't see anything suspicious. Is
>> there any chance you can strip that down to a small testcase with a few
>> symbols? That would help debugging a lot.
>
>Sure can.  Create a file (let's call it foo.c)... it just contains:
>
>     int foo_tester()
>     {
>          return(twenty());
>     }
>
>Then run the following:
>
>     gcc -fPIC -c foo.c
>
>After the compilation, run:
>
>     gcc -shared -o libfoo.so foo.o
>     gcc -shared -Wl,-Bsymbolic -o libfoo.so foo.o
>     gcc -shared -Wl,--noinhibit-exec -Wl,-Bsymbolic -o libfoo.so foo.o
>
>On Intel, the first succeeds, the second fails (as expected), and the
>third succeeds in building a .so file, even with the "undefined
>reference" error.
>
>On PPC, the first succeeds, but the second and third both fail.

Ok, I've put up a 1b RPM for testing. Let me know if it works as expected. Note
the dev.linuxppc.org has changed IP address, so you might have to use the direct
169.207.161.2.

Franz.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
