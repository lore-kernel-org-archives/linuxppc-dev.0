Message-ID: <XFMail.990305191140.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <36E02AD1.8FACA47E@aplcomm.jhuapl.edu>
Date: Fri, 05 Mar 1999 19:11:40 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: harry eaton <haceaton@aplcomm.jhuapl.edu>
Subject: RE: Segfaults in powerpc ld (binutils-2.9.1-19a)
Cc: linuxppc-dev@lists.linuxppc.org, egcs@egcs.cygnus.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a known (at least to me) BFD problem.  I believe that it would
be fixed by applying this patch:

 Index: elf32-ppc.c
 ===================================================================
 RCS file: bfd/elf32-ppc.c,v
 retrieving revision 1.86
 diff -p -r1.86 elf32-ppc.c
 *** elf32-ppc.c        1998/08/02 10:22:31     1.86
 --- elf32-ppc.c        1999/02/03 16:09:54
 *************** ppc_elf_relocate_section (output_bfd, in
 *** 2753,2760 ****
   
     local_got_offsets = elf_local_got_offsets (input_bfd);
   
 !   splt = bfd_get_section_by_name (dynobj, ".plt");
 !   sgot = bfd_get_section_by_name (dynobj, ".got");
   
     for (; rel < relend; rel++)
       {
 --- 2753,2763 ----
   
     local_got_offsets = elf_local_got_offsets (input_bfd);
   
 !   if (dynobj)
 !     {
 !       splt = bfd_get_section_by_name (dynobj, ".plt");
 !       sgot = bfd_get_section_by_name (dynobj, ".got");
 !     }
   
     for (; rel < relend; rel++)
       {

Can you rebuild the BINUTILS with this patch and let me know if it solves
your problem?

On 05-Mar-99 harry eaton wrote:
> I'm getting seg-faults in ld when I try to compile twin on a powerpc
> linux system.  I'm using binutils-2.9.1-19a
> and egcs-1.1-1c.
> 
> gcc is invoked with these arguments:
> 
> 
> -Wall -fwritable-strings -fPIC -shared  -Wl,-Bsymbolic
> 
> What specifically is happening is this:
>  on line 2856 of bfd/elf32-ppc.c (of binutls of course) the segfault
> occurs.
> 
> rel->r_info is R_PPC_REL24
> info->symbolic is true.
> the name of the section:  h->root.u.def.section is ".text"
> h->root.u.def.section->output_section is NULL !!!!
> 
> The NULL is the problem since it is de-referenced.
> 
> I added a test for this NULL, and just used a break
> to stop the segfault.  That stops the segfault but
> seems to just lose the symbol?  (Later stages of the
> make complain about missing symbols during
> linking.)  I also added some statements to print
> when the this line is encountered and the output_section
> is not 0.  I've compiled a few other things with it
> configured this way, and the print is never triggered.
> It seems like this particular relocation situation is
> very seldom encountered, so the bug may have been
> lurking for a while.
> 
> I have to admit that I don't know enough about the
> linker to figure out what's going on.
> 
> the twin source consistently causes this problem,
> but I have not been able to make  a small example.
> 
> Ideas?
> 
> harry
> 

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
