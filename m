From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@denise.shiny.it>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Console text selection bug
Date: Mon, 5 Mar 2001 22:35:53 +0100
Message-Id: <19350128150737.3378@smtp.wanadoo.fr>
In-Reply-To: <3AA12536.DAF3B1A7@denise.shiny.it>
References: <3AA12536.DAF3B1A7@denise.shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>When I select text in console it's scrambled. I looked at the
>aty128 sources, but I didn't find anything about it. Where is
>the code that manages selection/cut/paste ?
>
>The selected text is scrambled in this way: every char has
>the bits 1,2,3 swapped with bits 5,6,7 respectively (bits
>numbered left to right). I don't know what can cause this
>strange behaviour... I thought the console screen was a
>simple array of char/colour pairs.

It's an endian bug in fbcon when accessing the text/attribute buffer.

I think someone posted a fix for it, You may have more luck asking on
the fbdev mailing list to the fbdev maintainers what's up.

I think it's related to fbcon_invert_region() not using the access
macros and directly tapping the buffer, causing attributes & text
to be messed up.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
