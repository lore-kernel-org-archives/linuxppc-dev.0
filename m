From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Hanley <sjh@wibble.net>,
        Linux PPC Dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: agpgart? or how to use dri?
Date: Fri, 2 Feb 2001 01:02:03 +0100
Message-Id: <19341227173347.15692@mailhost.mipsys.com>
In-Reply-To: <20010202095306.A7859@chiru.svana.org>
References: <20010202095306.A7859@chiru.svana.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>> I slightly hacked my own
>> to build since I lack the glide libs necessary for the 3dfx stuff to
>compile.
>
>what does glide have to do with this? isnt that only used with tdfx?

Yes, but the Makefile of the kernel DRM modules will build all modules
(3dfc, ati, ...) and so would fail when the glide headers are not there.

>So where do I find out about pci gart and how to make the r128 driver
>compile using it? Should I simply read through the Makefil and the r128 code
>and ifnd the stuff related to pci gart and enable anything there possibly
>turned off or some such?

Well, what I did was to:

 - Get Gareth CVS branch
 - Make World
 - remove tdfx in the drivers Makefile and the DRM kernel makefile
 - Re-make
 - Make DRM modules (make -f Makefile.linux in the DRM kernel directory)
 - make install

Note that for a Pismo (rage M3), you'll also need to edit your XF86Config
and do

 - Disable "UseFBDev" option as the current aty128fb does work correctly
in 16 bits
 - Set Option "ProgramFPRegs" "No" or the driver will crash
 - Set your bit depth to 16 bits (not 15 nor 32)

Also, using windowed GL apps tend to hang the server as soon as a 2D
operation is done. This problem seem to be specific to the RageM3 of the
Pismo.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
