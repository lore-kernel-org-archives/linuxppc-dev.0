Message-ID: <3BF5124D.9080502@humboldt.co.uk>
Date: Fri, 16 Nov 2001 13:19:09 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: FS on flash (initrd, JFFS, ...)
References: <6B546A602AD2D211BFF00008C7A42889041D6CBE@hrtades2.atea.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Goddeeris Frederic wrote:


> 2. Can Linux boot from a JFFS (or any other like CRAMFS) or is a Randisk the
> only option?


I've set up a board with root on JFFS2. The procedure in the HOWTO for
JFFS just worked.


> 3. JFFS blocks while performing garbage collection. I suppose it is only the
> applications/threads that are working with the files on the JFFS that are
> blocked or does this garbage collection take a lot of CPU power so that also
> other processes/threads are affected?


The longest part of the process is erasing blocks, which isn't CPU
intensive. This will depend a lot on your application.


> 5. JFFS is stable?


Stable, but with known deadlocks as a result of design problems.


> 6. Is JFFS2 fit for use in a product yet?


I'd say JFFS2 is a lot safer for use in the field, because it doesn't
have the deadlocks that JFFS has. I've had one JFFS2 filesystem
destroyed by a broken driver which wrote over random kernel memory, but
it's robust against other problems.

That is the real risk of an FFS against an initrd. The initrd is much
less likely to be overwritten by a bad driver or application, and makes
it much easier to have a "return to factory settings" option



--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
