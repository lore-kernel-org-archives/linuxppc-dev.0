From: "Bob Doiron" <bob.doiron@amirix.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Possbile bug in hashtable.S : add_hash_page
Date: Mon, 28 Jun 2004 15:40:26 -0300
Message-ID: <NBBBIKIPCKOLLCLIHBIMMEPNEBAA.bob.doiron@amirix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all. I'm working on an embedded ppc / linux project and I've run into
what looks like a possible bug.

On entry to add_hash_page the return address is stored on the stack like so:

   _GLOBAL(add_hash_page)
      mflr  r0
      stw   r0,4(r1)  <-- store into *(r1) + 4

	< do some magic >
      < then disabled interrupts >


then upon return, it's retreived like so:

      mtmsr	r10 <--- interrupts enabled here
	SYNC_601
	isync

	lwz	r0,4(r1) <-- read out *(r1) + 4
	mtlr	r0
	blr


However - r1 remains unchanged within the function. As it stands, it seems
that an interrupt could come along and scrible on our return address by
using the unchanged stack pointer. What I've been seeing is that when under
heavy interrupt load (nfs mount kernel compile for example) my ppc gets
stuck in a "here: jump here" loop right at the blr instruction listed above.
Inspecting the stack @ 4(r1) showed that it did in fact have the address of
the blr instruction there, which led me to beleive that it is getting
corrupted by an interrupt. Simply changing the "4" offset in 4(r1) to 12
makes for a rock stable kernel, but it's a horrific hack.

I guess my question is, am I missing something? or is this a real bug? My
extremely limited ppc assembly tells seems to think that r1 should be moved
prior to using stack space...

--Bob


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
