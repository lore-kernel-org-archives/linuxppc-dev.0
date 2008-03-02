Return-Path: <SRS0+0296f4202981db47be11+1652+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA22EDDE48
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2008 02:09:34 +1100 (EST)
Subject: TOC overflow on PPC64 (Ocaml)
From: David Woodhouse <dwmw2@infradead.org>
To: amodra@bigpond.com.au
Content-Type: text/plain
Date: Sun, 02 Mar 2008 15:09:26 +0000
Message-Id: <1204470566.3891.83.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In a fit of stupidity I worked on porting OCaml to PPC64:
	http://git.infradead.org/?p=users/dwmw2/ocaml-ppc64.git

It seems to work fine, mostly -- but when building large programs such
as CIL I found that I overflow the TOC -- I'm using more than 64KiB. An
example of this problem is at http://david.woodhou.se/ocaml-test.tar.gz:

	 $ make
	as -a64 -o cil.o camlasm6944b7.s
	ld -melf64ppc -r -o foo *.o *.a
	ld: TOC section size exceeds 64k

It shows the assembler output from the OCaml compiler for one file, as
well as the resulting link error.

I looked at what GCC does for -mminimal-toc, and I'm slightly confused.
I don't understand why it still has .TOC.@tocbase in the function
descriptor and then uses double-indirect access from the global table.
What's the point in having a TOC pointer in function descriptors if
you're just going to use the same global table all the time anyway? Why
not change the function descriptor to point r2 to its own table?

For OCaml, I was going to leave the TOC empty and emit something like
a .toc1 section as GCC does -- but I was going to just leave the
'real' .toc section empty, and put the address of the local table into
the function descriptors for each function. But I'm slightly concerned
about doing that without knowing why the C compiler doesn't do it that
way. For example, when I compile 'int a; int main(void) { return a; }'
with -mminimal-toc why do I see this:

	main:
	        .quad   .L.main,.TOC.@tocbase
	        .previous
	        .type   main, @function
	.L.main:
	        std 30,-16(1)
	        ld 30,.LCTOC0@toc(2)
	        ld 9,.LC0-.LCTOC1(30)
	
	... and not this:
	
	main:
	        .quad   .L.main,.LCTOC1
	        .previous
	        .type   main, @function
	.L.main:
	        ld 9,.LC0-.LCTOC1(2)


OCaml _seems_ to work with the following patch, albeit with lots of
bitching about 'unexpected reloc type 38 in .opd section' from the
linker. Is there a better way to fix it?

diff --git a/asmcomp/power64/emit.mlp b/asmcomp/power64/emit.mlp
index 73f4680..1e7824b 100644
--- a/asmcomp/power64/emit.mlp
+++ b/asmcomp/power64/emit.mlp
@@ -77,7 +77,7 @@ let emit_label lbl =
 
 let toc_space =
   match Config.system with
-  | "elf" | "bsd" -> "	.section \".toc\",\"aw\"\n"
+  | "elf" | "bsd" -> "	.section \".toc1\",\"aw\"\n"
   | "rhapsody"    -> "	.toc\n"
   | _ -> assert false
 
@@ -183,7 +183,7 @@ let emit_tocentry entry =
 
 let emit_tocref entry = 
     let lbl = tocref_label (!tocref_entries,entry) in
-      emit_label lbl; emit_string "@toc(2) #"; emit_tocentry entry
+      emit_label lbl; emit_string "-.TOCBASE(2) #"; emit_tocentry entry
 
 
 (* Output a load or store operation *)
@@ -846,7 +846,7 @@ let fundecl fundecl =
       `	.align 3\n`;
       `	.type	{emit_symbol fundecl.fun_name}, @function\n`;
       `{emit_symbol fundecl.fun_name}:\n`;
-      `	.quad .L.{emit_symbol fundecl.fun_name},.TOC.@tocbase\n`;
+      `	.quad .L.{emit_symbol fundecl.fun_name},.TOCBASE\n`;
       `	.previous\n`;
       `	.align	2\n`;
       emit_string code_space;
@@ -951,8 +951,9 @@ let end_assembly() =
       (List.rev !jumptbl_entries);
     jumptbl_entries := []
   end;
+  emit_string toc_space;
+  `.TOCBASE = . + 32768\n`;
   if !tocref_entries <> [] then begin
-    emit_string toc_space;
     List.iter
       (fun (lbl, entry) ->
         `{emit_label lbl}:\n`;
@@ -960,7 +961,7 @@ let end_assembly() =
         TocFloat f ->
 	  `	.double	{emit_tocentry entry}\n`
 	| _ -> 
-          `	.tc	{emit_label lbl}[TC],{emit_tocentry entry}\n`
+          `	.quad	{emit_tocentry entry}\n`
       )
       !tocref_entries;
       tocref_entries := []


-- 
dwmw2
