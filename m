To: costabel@wanadoo.fr
Cc: linuxppc-dev@lists.linuxppc.org, cort@ppc.kernel.org
Subject: Re: Bug in vger 2.2.10 and 2.3.4 (Re: Problems with vger 2.3.3/4)
In-Reply-To: Your message of "Wed, 02 Jun 1999 14:19:09 +0200"
	<3755213D.3BB3C8B6@wanadoo.fr>
References: <3755213D.3BB3C8B6@wanadoo.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19990603012440G.roikawa@rr.iij4u.or.jp>
Date: Thu, 03 Jun 1999 01:24:40 GMT
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Martin Costabel <costabel@wanadoo.fr>
Subject: Bug in vger 2.2.10 and 2.3.4 (Re: Problems with vger 2.3.3/4)

> Index: arch/ppc/mm/init.c
> ===================================================================
> RCS file: /cvs/linux/linux/arch/ppc/mm/init.c,v
> retrieving revision 1.165
> retrieving revision 1.166
> diff -u -r1.165 -r1.166
> --- arch/ppc/mm/init.c  1999/05/14 22:37:29     1.165
> +++ arch/ppc/mm/init.c  1999/05/22 18:18:30     1.166
> @@ -1,5 +1,5 @@
>  /*
> - *  $Id: init.c,v 1.165 1999/05/14 22:37:29 cort Exp $
> + *  $Id: init.c,v 1.166 1999/05/22 18:18:30 cort Exp $
>   *
>   *  PowerPC version 
>   *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
> @@ -402,7 +402,7 @@
>     for (i = 0; i < size; i += PAGE_SIZE)
>         map_page(&init_task, v+i, p+i, flags);
>  out:
> -   return (void *) (v + (p & ~PAGE_MASK));
> +   return (void *) (v + (addr & ~PAGE_MASK));
>  }
>  
>  void iounmap(void *addr)
> 
> This patch had been proposed on May 21 by R. Oikawa and almost
> immediately been corrected, see
> http://lists.linuxppc.org/listarcs/linuxppc-user/199905/msg00680.html
> Unfortunately, the correction didn't make it into the vger tree. I don't
> know if the correction is good, but I never had problems with the
> version before the patch.
 Sorry, but please see the newer patch in msg00680.html. Simply replacing
-   return (void *) (v + (p & ~PAGE_MASK));
+   return (void *) (v + (addr & ~PAGE_MASK));
breaks iomap for BAT mapped devices(ex. mac-io/heathrow devices such as
ide, mace, bmac, etc.). Please use the newer one.


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
