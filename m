Message-ID: <3DB58D93.50008@embeddededge.com>
Date: Tue, 22 Oct 2002 13:40:35 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Hans Feldt <Hans.Feldt@uab.ericsson.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 CPM commands, need better resource ctrl?
References: <3DB57883.4040109@uab.ericsson.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hans Feldt wrote:

> Isn't there a need for a central place to handle CPM commands?

You could make it an inline function or macro, but I'm not sure
it's worth it.  All CPM drivers must have knowledge of how they
may affect others and take care to ensure incorrect operation
doesn't occur.  In this case, there isn't a consistent use of
sending CPM commands, as you mentioned in your message.  There are
different contexts in which drivers send these commands.  It
doesn't make sense for a driver to continue without waiting for
the command to complete, so there isn't any need to wait for this
prior to sending a command.

> m8260_cpm_cmd(...)
>     disable ints
>     bounded wait until FLG is clear
>     if not clear => ???
>     write to CPCR
>     enable ints

A more proper order of operation would be:
	disable ints
	write CPCR
	bounded wait until FLG is clear
	enable ints
	return status

In some cases, it could be argued for a performance benefit to actually
perform other operations while waiting for the CPM command to finish.


> ....Disabling irqs in the
> atm driver around CPCR handling seems to fix that problem.

Then....that's what you should do.  It isn't always appropriate to
generally disable/enable interrupts in a common function because of
the driver context when the CPCR is accessed.  We also have to be
careful about making a generic and abstract CPM interface, since the
overhead of such functions would have a negative affect in an area
where we are sensitive to performance.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
