Message-ID: <37562033.2355E4DA@wanadoo.fr>
Date: Thu, 03 Jun 1999 08:26:59 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Paul.Mackerras@cs.anu.edu.au
CC: linuxppc-dev@lists.linuxppc.org, cort@ppc.kernel.org
Subject: Re: Bug in vger 2.2.10 and 2.3.4 (Re: Problems with vger 2.3.3/4)
References: <374D8E2A.48871830@wanadoo.fr> <3755213D.3BB3C8B6@wanadoo.fr> <199906030250.MAA04127@tango.anu.edu.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
> 
> Martin Costabel <costabel@wanadoo.fr> wrote:
> 
> > A while ago I reported about boot problems with the vger 2.3.x kernel
> > after May 22. Now I found that this same bug has crept into the "stable"
> > tree, starting with 2.2.10 on May 30. After some digging, I found the
> > culprit. It is the file arch/ppc/mm/init.c, patched (wrongly) as
> > follows:
> [snip]
> > -   return (void *) (v + (p & ~PAGE_MASK));
> > +   return (void *) (v + (addr & ~PAGE_MASK));
> 
> In fact that patch is correct but you also need this patch (which I'm
> about to check into vger):
> 
> --- linux/arch/ppc/mm/init.c    Sat May 29 20:24:09 1999
> +++ pmac/arch/ppc/mm/init.c     Thu Jun  3 10:13:00 1999
> @@ -371,7 +371,7 @@
>          * same virt address (and this is contiguous).
>          *  -- Cort
>          */
> -       if ( (v = p_mapped_by_bats(addr)) /*&& p_mapped_by_bats(addr+(size-1))*/ )
> +       if ( (v = p_mapped_by_bats(p)) /*&& p_mapped_by_bats(p+size-1)*/ )
>                 goto out;
>  #endif /* CONFIG_8xx */

In the meantime I applied the second patch proposed by Ryuichi Oikawa, and it 
works for me. I am writing this running under 2.3.4. This patch is  

 diff -u -r1.166 init.c
--- arch/ppc/mm/init.c  1999/05/22 18:18:30     1.166
+++ arch/ppc/mm/init.c  1999/06/02 22:51:47
@@ -371,8 +371,10 @@
         * same virt address (and this is contiguous).
         *  -- Cort
         */
-       if ( (v = p_mapped_by_bats(addr)) /*&& p_mapped_by_bats(addr+(size-1))*/ )
+       if ( (v = p_mapped_by_bats(addr)) /*&& p_mapped_by_bats(addr+(size-1))*/ ){
+               addr = 0; /* v already contains page offset */
                goto out;
+       }
 #endif /* CONFIG_8xx */

        if (mem_init_done) {

Note that I don't understand what is going on here. I am just your 
typical dumb user :-)

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
