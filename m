Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>,
	"LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: my_console_write
Date: Tue, 15 Oct 2002 07:23:52 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFCEHGDNAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <003301c2735c$4def2960$0700a8c0@pc005>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> After this no other messages are shown on the console and the program is
> running in the infinite loop.
>
> I have then tried to stop the PPCboot over the prompt, giving the command
> "bootp" and "bootm" manually.
>

There could be a couple problems here:
1. With the EST8260 configuration, the simple boot loader is used and it
receive a bd_info structure describing clocks etc. Is this correct?

2. There was a problem in embed_config.c where the code to initialize the
8260 clocks was not called. Check that this is right.

3. We had an infinite loop problem with a different PPC. I believe it is
decompress.c, where all the boot messages are printed from, right after if
calls embed_conf() it falls into a loop looking for keyboard input for
custom parameters. You can try commenting out this loop.

I hope this helps.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
