Return-Path: <amodra@bigpond.net.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EFBD2B7066
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 14:11:30 +1000 (EST)
Received: from nskntmtas03p.mx.bigpond.com (nskntmtas03p.mx.bigpond.com
	[61.9.168.143]) by ozlabs.org (Postfix) with ESMTP id CA42DDDDF4
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 14:11:26 +1000 (EST)
Date: Fri, 10 Jul 2009 13:41:24 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Edmar Wienskoski-RA8797 <edmar@freescale.com>
Subject: Re: binutils 2.19 issue with kernel link
Message-ID: <20090710041123.GD3181@bubble.grove.modra.org>
References: <09159ADA-39F9-419E-AE46-4CFAE612AFB9@kernel.crashing.org>
	<20090708233954.GA3181@bubble.grove.modra.org>
	<E6EB8DA7-8B38-4C97-BE3C-4649DFA295C8@kernel.crashing.org>
	<AB02ECF3-9C72-436B-A946-CBCCD3859762@kernel.crashing.org>
	<20090709044007.GB3181@bubble.grove.modra.org>
	<4B3B917C-C8B0-416B-888D-13E6C0645BF8@kernel.crashing.org>
	<4A5645A9.3080003@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A5645A9.3080003@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	bug-binutils@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 09, 2009 at 02:31:53PM -0500, Edmar Wienskoski-RA8797 wrote:
> Kumar Gala wrote:
>>
>> On Jul 8, 2009, at 11:40 PM, Alan Modra wrote:
>>
>>> On Wed, Jul 08, 2009 at 10:52:59PM -0500, Kumar Gala wrote:
>>>> To further verify this if I switch the -me500 to -mspe and build things
>>>> seem to be ok.  This further points at some APU section related bug.
>>>
>>> Like omitting .PPC.EMB.apuinfo from your kernel link script?  See the
>>> ld info doc on orphan sections.
>>
>> Ok, not terribly enlightening, but why would .PPC.EMB.apuinfo sections  
>> be different than something like .debug sections which we also dont  
>> list in the linker script.

Because .PPC.EMB.apuinfo is a note section rather than a debugging
section.  Orphan non-alloc note sections will be placed before
.comment or debug sections while orphan debug sections go right to the
end.  Now, I'll bet you don't have .comment in your script so it too
is an orphan.

> I understand your arguments, but there is something inconsistent about this.
> If I change the script to be:
>        _end3 = . ;
>        . = _end3;
>        . = ALIGN(PAGE_SIZE);
>        _end = . ;
>        PROVIDE32 (end = .);
> }
> The result is corrected:
> c067f678 A _end3
> c0680000 A _end
>
> Why the apuinfo section with zero VMA sometimes interfere with "." and  
> sometimes not ?

That is weird.  You'll need to run ld under gdb to find out.  I'd
expect the orphan apuinfo section to be placed before the first
assignment to dot in both cases, or at the end of the script in both
cases, with placement depending on whether you hit an orphan .comment
or debug section before the orphan .PPC.EMB.apuinfo.


The underlying reason is that if you provide a link script that
doesn't mention a section, then ld is free to place that section
anywhere.  Quoting from the ld info doc:

"Orphan sections are sections present in the input files which are not
explicitly placed into the output file by the linker script.  The
linker will still copy these sections into the output file, but it has
to guess as to where they should be placed.  The linker uses a simple
heuristic to do this.  It attempts to place orphan sections after
non-orphan sections of the same attribute, such as code vs data,
loadable vs non-loadable, etc.  If there is not enough room to do this
then it places at the end of the file.

For ELF targets, the attribute of the section includes section type as
well as section flag."


That's all as expected, and in your case you don't have a section with
the same attribute as .PPC.EMB.apuinfo so it should go to the end.
However, you have multiple orphan sections being added.  After the
first of these is added, you have sections after your end symbol
assignments, and when there are assignments it gets tricky.  The
relevant part of the ld info doc says:


"Setting symbols to the value of the location counter outside of an
output section statement can result in unexpected values if the linker
needs to place orphan sections.  For example, given the following:

SECTIONS
{
    start_of_text = . ;
    .text: { *(.text) }
    end_of_text = . ;

    start_of_data = . ;
    .data: { *(.data) }
    end_of_data = . ;
}

If the linker needs to place some input section, e.g. .rodata, not
mentioned in the script, it might choose to place that section between
.text and .data.  You might think the linker should place .rodata on
the blank line in the above script, but blank lines are of no
particular significance to the linker.  As well, the linker doesn't
associate the above symbol names with their sections.  Instead, it
assumes that all assignments or other statements belong to the
previous output section, except for the special case of an assignment
to '.'.  I.e., the linker will place the orphan .rodata section as if
the script was written as follows:

SECTIONS
{
    start_of_text = . ;
    .text: { *(.text) }
    end_of_text = . ;

    start_of_data = . ;
    .rodata: { *(.rodata) }
    .data: { *(.data) }
    end_of_data = . ;
}

This may or may not be the script author's intention for the value of
start_of_data.  One way to influence the orphan section placement is
to assign the location counter to itself, as the linker assumes that
an assignment to '.' is setting the start address of a following
output section and thus should be grouped with that section.  So you
could write:

SECTIONS
{
    start_of_text = . ;
    .text: { *(.text) }
    end_of_text = . ;

    . = . ;
    start_of_data = . ;
    .data: { *(.data) }
    end_of_data = . ;
}

Now, the orphan .rodata section will be placed between end_of_text and
start_of_data."


Putting this all together:
a) ld places .comment or some debug section at end
b) ld places .PPC.EMB.apuinfo before the other orphan section, and
thinks your assignments to dot belong with the other orphan, so 
.PPC.EMB.apuinfo goes before them.

As no doubt you've already found, you can fix your link script by not
using ". = ALIGN(PAGE_SIZE)"; instead use "sym = ALIGN(PAGE_SIZE)".

Hmm, having said all that, the following linker patch seems reasonable
to me and probably won't break anything else (always some risk).
Please test it for me.

Index: ld/ldlang.c
===================================================================
RCS file: /cvs/src/src/ld/ldlang.c,v
retrieving revision 1.311
diff -u -p -r1.311 ldlang.c
--- ld/ldlang.c	25 Jun 2009 13:18:46 -0000	1.311
+++ ld/ldlang.c	10 Jul 2009 04:04:57 -0000
@@ -1615,10 +1615,12 @@ output_prev_sec_find (lang_output_sectio
    idea is to skip over anything that might be inside a SECTIONS {}
    statement in a script, before we find another output section
    statement.  Assignments to "dot" before an output section statement
-   are assumed to belong to it.  An exception to this rule is made for
-   the first assignment to dot, otherwise we might put an orphan
-   before . = . + SIZEOF_HEADERS or similar assignments that set the
-   initial address.  */
+   are assumed to belong to it, except in two cases;  The first
+   assignment to dot, and assignments before non-alloc sections.
+   Otherwise we might put an orphan before . = . + SIZEOF_HEADERS or
+   similar assignments that set the initial address, or we might
+   insert non-alloc note sections among assignments setting end of
+   image symbols.  */
 
 static lang_statement_union_type **
 insert_os_after (lang_output_section_statement_type *after)
@@ -1662,7 +1664,12 @@ insert_os_after (lang_output_section_sta
 	  continue;
 	case lang_output_section_statement_enum:
 	  if (assign != NULL)
-	    where = assign;
+	    {
+	      asection *s = (*where)->output_section_statement.bfd_section;
+
+	      if (s == NULL || (s->flags & SEC_ALLOC) != 0)
+		where = assign;
+	    }
 	  break;
 	case lang_input_statement_enum:
 	case lang_address_statement_enum:

-- 
Alan Modra
Australia Development Lab, IBM
