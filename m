Message-ID: <19990512221242.30065@ibrium.se>
Date: Wed, 12 May 1999 22:12:42 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: puetzk6715@uni.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: mac-on-linux (g3/r5 problems)
References: <Pine.PMDF.3.96.990512134259.539075676A-100000@uni.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.PMDF.3.96.990512134259.539075676A-100000@uni.edu>; from puetzk6715@uni.edu on Wed, May 12, 1999 at 01:52:39PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 12, 1999 at 01:52:39PM -0500, puetzk6715@uni.edu wrote:
> 
> Everything compiled, but the link failed, because
> arch/ppc/macos/macos_ksyms.c and kernel/ksyms.c both tried to define
> __ksymtab_find_vma and .kstrtab_find_vma. At this point I munged it
> (commented out EXPORT_SYMBOL(find_vma) in arch/ppc/macos/macos_ksyms.c)
> and it built (I was curious how much farther I'd get). How am I supposed
> to get past this / what did I do wrong that caused it?
> 
> The kenel boots, seems to work, but any attempt to insert macos_mod fails
> because clear_tlb_table is not defined - this symbol is in my vmlinux
> file, but does not appear in /proc/ksyms. Is this the 603 bug (since the
> 750 is like a 603 in many ways, and I know the problem is related to
> memory mapping...)?
>
The problem is that the clear_tlb_table symbol is not exported.
I think it should be sufficient to add EXPORT_SYMBOL(clear_tlb_table)
to macos_ksyms.c. Even better, compile the kernel with the module
config option set to no (module support is probably going
to disappear since it is only a relatively small part of the 
code which actually can be put in a module).

/Samuel

-- 

----------------------------------------------------------
  E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
    Phone/fax: (home) +46 4418431, (work) +46 7908470   
----------------------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
