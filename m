Subject: Re: ppc_irq_dispatch_handler and unhandled interrupts
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: devel list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <15838.45984.311938.41129@argo.ozlabs.ibm.com>
References: <1037897936.10521.89.camel@granite.austin.ibm.com>
	<15838.45984.311938.41129@argo.ozlabs.ibm.com>
Date: 25 Nov 2002 16:04:29 -0600
Message-Id: <1038261873.1077.127.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2002-11-22 at 16:45, Paul Mackerras wrote:
>
> This is the wrong fix IMO.  The situation is no different to calling
> disable_irq during an interrupt handler, and as the comment says, the
> ->end() handler has to deal with that.  The problem is that if we
> don't have an ->end() handler we unconditionally call the ->enable()
> handler, which (correctly) just unconditionally enables the
> interrupt.

You're right, not the right fix. I was on a obsolete tree which did not
have a ppc405_uic_end.

But why not require all handlers to have an ->end() handler? If you look
at arch/i386/kernel/irq.c do_IRQ you'll see they just assume there is an
end, simplifying code and removing at least one conditional from the irq
path. In linuxppc-2.5 there are 4 pic drivers entirely without end
handlers: adir_pic, cpc700_pic, gt64260_pic, and ppc403_pic.

-Hollis
--
PowerPC Linux
IBM Linux Technology Center

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
