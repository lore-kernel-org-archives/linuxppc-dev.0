Mime-Version: 1.0
Message-Id: <v04220800b6ca30dbefe5@[10.0.0.42]>
In-Reply-To: <19350128150737.3378@smtp.wanadoo.fr>
References: <3AA12536.DAF3B1A7@denise.shiny.it>
 <19350128150737.3378@smtp.wanadoo.fr>
Date: Mon, 5 Mar 2001 22:18:42 -0800
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Giuliano Pochini <pochini@denise.shiny.it>,
	<linuxppc-dev@lists.linuxppc.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Console text selection bug
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:35 PM +0100 3/5/01, Benjamin Herrenschmidt wrote:
>>When I select text in console it's scrambled. I looked at the
>>aty128 sources, but I didn't find anything about it. Where is
>>the code that manages selection/cut/paste ?
>>
>>The selected text is scrambled in this way: every char has
>>the bits 1,2,3 swapped with bits 5,6,7 respectively (bits
>>numbered left to right). I don't know what can cause this
>>strange behaviour... I thought the console screen was a
>>simple array of char/colour pairs.
>
>It's an endian bug in fbcon when accessing the text/attribute buffer.
>
>I think someone posted a fix for it, You may have more luck asking on
>the fbdev mailing list to the fbdev maintainers what's up.
>
>I think it's related to fbcon_invert_region() not using the access
>macros and directly tapping the buffer, causing attributes & text
>to be messed up.

I saw this problem in 2.4.x until I turned off the config option for
VGA consoles.  Then it went away.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
