Date: Wed, 17 Nov 1999 11:39:33 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Andreas Tobler <a.tobler@schweiz.ch>
cc: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: again 2.3.28
In-Reply-To: <3832F9AD.9CD1B9E5@pop.agri.ch>
Message-ID: <Pine.LNX.4.10.9911171133220.5126-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



	i messed aroudn with .28 last night and it seems to die *after*
mmu_init but before start_kernel, you can test this by making and export a
function which simply prom_print("got here\n");'s and then calling it from
head.S with the asm "bl	my_got_here_function".  it also gets passed
loading the new hash table.

thats all i could do last nite cause i left my serial cable at work :(
what i would suggest is that you first apply my arch/ppc/mm/init.c fix and
then use a serial debug console (make sure you have this in your kernel),
and use kernel arg "console=ttyS0" and have a machine with a terminal
running nearby.  it could be dieing early in start_kernel...


ani


On Wed, 17 Nov 1999, Andreas Tobler wrote:

> 
> Hi,
> 
> my investigation brought me to the point, where I think the break must
> be between 
> prom_init (in prom.c called from Head.S) and identify_machine (in
> setup.c called from Head.S)
> This is my interpretation of the code in Head.S? I certainly could be wrong.....
> Any ideas?
> 
> Thanks,
> Andreas
> -- 
> | Andreas Tobler				
> | CH-8004 Zuerich 							
> | E-Mail: andreas.tobler@alcatel.ch	  a.tobler@schweiz.ch
> -----------------------------------------------------------
> 
> 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
