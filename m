Message-ID: <386ABF52.922267E9@ctam.com.au>
Date: Thu, 30 Dec 1999 13:11:30 +1100
From: Brendan J Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: dony <dony.he@huawei.com.cn>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Please help me...
References: <386C150F.22B1A3D0@huawei.com.cn>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


dony wrote:

> Hi,
>       Now I am trying to embed linux onto our MPC860-based board. I have
> some questions which may be solved by you embed-linux gurus....
>      What I want to do  is the following:
>     1     Initialize the MPC860 CPU , memory, serial port, enet port .
>     2    Download  the linux powerpc kernel (which I have cross-compiled
> on my X86 box)
>            from the TFTP server to RAM on board.
>     3    run the kernel.
> Now the 1 and 2 step work well, but when I download the kernel to RAM on
> board, It just cannot run.Do you know why? How can I programme to make
> it run? Since the kernel is a compressed image (zvmlinux), need I make
> some codes to decompress it and then run it? if so, how to do it?

So I take it that you have written your own boot loader that is in
ROM/Flash which fetches the kerenl from a TFTP server and places it in RAM
somewhere.  Good.  How does your bootloader know where to put the code ?
Does it look at the internals of the elf image or is it an s-record file
you are downloading ?  The image must be placed at or above 2MB.  You will
have problems if it is below 2MB.  I have my kernel in Flash at FFE00000 or
FF800000.  Once the kernel is loaded, you have to jump to the start
address.

I assume you are using the mbxboot code for the kernel.  Are you ?  What
board are you using ?
The mbxboot code will copy the iteself to location 0x100000 (1MB) and jump
to that address so it is running from RAM.  It then decompress the kernel
image to location 0 and jumps to the start of the kernel.

Can you send the output of "objcopy --headers zImage" to the list.  Also
send the output of the mbxboot loader messages with the loaded and
relocated addresses (if the code is getting that far).

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
