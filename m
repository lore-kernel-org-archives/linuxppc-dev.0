Date: Thu, 21 Sep 2000 16:18:52 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Paolo Scaffardi <arsenio@tin.it>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Custom serial keyboard: playing dirty with the serial console
In-Reply-To: <003601c02397$670ccd60$0a00010a@paoloweb>
Message-ID: <Pine.LNX.4.10.10009211618430.28518-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>From schmitz@opal.biophys.uni-duesseldorf.de Thu Sep 21 16:18:37 2000
Newsgroups:
Date: Thu, 21 Sep 2000 16:18:37 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Paolo Scaffardi <arsenio@tin.it>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Custom serial keyboard: playing dirty with the serial console
Fcc: sent-mail
In-Reply-To: <003601c02397$670ccd60$0a00010a@paoloweb>
Message-ID: <Pine.LNX.4.10.10009211614300.28518@opal.biophys.uni-duesseldorf.de>
X-Reply-UID: (2 > )(1 940426103 5996)/home/opal/schmitz/mail/linuxppc-dev
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII

> Everything is now ok: i receive correct packets, convert them to XT
> scancodes and call 'handle_scancode' to process them.
>
> But 'handle_scancode' only prints characters to the console, without
> apparently processing them. I see everything i write, but when i press enter
> (scancode 0x1c), i only see a new line in the console, not any new bash
> prompt.
>
> Why this? Is it correct to intercept the serial console and not returning
> single characters from inside it but from 'handle_scancode' mode?

I don't think so - serial console is supposed to be used with terminals or
terminal emulators which send ASCII codes not scancodes. Try to directly
call handle_scancode (possibly via some glue code like keyboard_input for
ADB) from the serial interrupt without going over the tty line discpline.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
