From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: asm info
Date: Thu, 18 Apr 2002 23:42:08 +0200
Message-Id: <20020418214208.642@smtp.adsl.oleane.com>
In-Reply-To: <XFMail.20020419093710.pochini@shiny.it>
References: <XFMail.20020419093710.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I want to write some small functions/peices of code in
>ppc assembly. I have ppc user manuals and the ABI, but
>I don't know the syntax. I need to know how to code asm
>inside the C source, and I need to know how to write a
>.S file to assemble and link with C object files. Where
>can I find the docs ?  Does gcc support Altivec ?

Hi Giuliano. Just out of curiosity: what do you plan to
"altivec'ize" ? I'm doing it here or there too (the current
xvid CVS for example contain some altivec stuff).

You can write a .S file and get it assembled with the current
binutils. Look at the various existing examples (kernel code
for example ;) on how to get a .S file assembled. Basically
export your function with

 .glob function_name
function_name:
    your code here
    blr

You may need some -mcpu=7400 though

Inline assembly is a lot more tricky because mostly of the way
the registers are "abstracted" by the inline assembler to let the
compiler assign them. You have some examples of code not using
this "abstract" feature though in the altivec code of the IDCT and
motion compensation in libmpeg2.

Now, in order to generate vec code from C using apple/moto C
extensions, you can either use the old "gcc-vec" which is a 2.95.2
version of gcc with altivec extensions available here or there on the
net, or compile the latest gcc 3.1 prerelease. The former is quite
buggy, I used it to generate .S files from altivec C that I could
tweak a bit before assembling, I avoid it for the main C sources of
the project (the non-vec ones).
The later support altivec with the -maltivec flag (and different
scheduling if you use -mcpu=7400 or -mcpu=7450). Though it also use
the new syntax for vector constants (basically replace (x,y,z,...)
constants with {x,y,z,...} and it will be happy).


Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
