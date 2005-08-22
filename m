Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id 9208268027
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 00:35:26 +1000 (EST)
Received: from [192.168.1.7] (wing [192.168.1.7]) (authenticated)
	by icarus.com (8.11.6/8.11.6) with ESMTP id j7MEZOl15027
	for <linuxppc-embedded@ozlabs.org>; Mon, 22 Aug 2005 07:35:24 -0700
Message-ID: <4309E2AC.9080404@icarus.com>
Date: Mon, 22 Aug 2005 07:35:24 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: mmap nocache on PPC, 2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


In an embedded system, I want a big chunk of virtual memory in the
user process to be uncached. I've created a virtual device driver that
has this mmap method:

static int heap_mmap(struct file*filp, struct vm_area_struct*vma)
{
	/* Mark this whole region uncached. The setup of this
	   additional flag, and the VM_RESERVED, are the whole point
	   of this module. This hopefully will cause all pages mapped
	   into this vma to be uncached. */
~      pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
~      vma->vm_flags |= VM_RESERVED;

~      vma->vm_ops = &heap_vm_ops;
~      heap_vm_open(vma);
~      return 0;
}

I then allocate in the nopage from get_free_page as usual. My
question is, "Is this doing what I think it is doing?"

- --
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDCeKrrPt1Sc2b3ikRAlsVAKDD6+O4ihBYkHreyqkNcQuuvKIK8wCg4b6v
jRBU8FJrOyczJJdPkicf22s=
=zMkX
-----END PGP SIGNATURE-----
