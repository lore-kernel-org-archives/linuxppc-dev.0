Date: Tue, 4 Feb 2003 14:53:25 +0100
Message-Id: <200302041353.h14DrOO14947@mailgate5.cinetic.de>
MIME-Version: 1.0
From: Frank Haverkamp <f.haverkamp@web.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Relocation of embedded ppc code
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I wrote program which was linked with -relocatable has a .got2 and a .fixup section.
I am loading this program to a different location in my memory and I adjust .got2 and
the .fixup accordingly (at least what I could see in my hardware debugger). Everything
seems to work fine, the C code is finding variables in .data and .bss using the global
offset table which I fixed. Now there is one thing which is not working as expected:

If I declare a variable in .data like this:

static void *ptr = my_func;

and reference it later in my code which was already moved:

void foo(void)
{
    printf("ptr=%p my_func=%p\n", ptr, my_func);
}

I am getting a result like this:

ptr = 0xfff00042 my_func=0x03100042

wich wonders me since I am sure that it uses the got to find ptr, but the value stored there,
is not relocated but just the value it got in the obj code. Accessing the pointer my_func
also seems to use the relocation tables since it print out the new location of my_func.

So I wonder is that intentionally like this or did I forget to relocate some data. If so where
can I find it .got2 and .fixup seem not to contain it? Why is there a destingtion between
fixup and got2? Why does the compiler generate two different tables which seem to have
the same (or only similar/if so what is the difference) meaning?

Any ideas hints or documents to look at?

Thanks,

Frank

--
Frank Haverkamp
f.haverkamp@web.de
______________________________________________________________________________
Den Komfort von WEB.DE FreeMail nutzen, aber die alten E-Mail-Adressen nicht
aufgeben? Kein Problem: http://freemail.web.de/features/?mc=021128


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
