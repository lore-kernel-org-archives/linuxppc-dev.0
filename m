Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id A107267A64
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Feb 2005 11:53:07 +1100 (EST)
Message-ID: <42153C71.9000500@icarus.com>
Date: Thu, 17 Feb 2005 16:53:05 -0800
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
References: <42152ADD.8040104@icarus.com>
	<20050218004327.GB10915@gate.ebshome.net>
In-Reply-To: <20050218004327.GB10915@gate.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux processes, tempfs and programs
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

Eugene Surovegin wrote:
| On Thu, Feb 17, 2005 at 03:38:05PM -0800, Stephen Williams wrote:
|>But if I do that, I want to remove the program from the directory
|>after I start it, so that the file does not take up ram space. Will
|>that actually work? I'm using exec(2) to execute the program file
|>wherever it is downloaded. Will a subsequent unlink of the file
|>have a result, or will the file continue to take up space as
|>backing store for the executable?
|
|
| I think unlink will remove the file from directory (so you won't be
| able to see it with ls), but it will still continue to to take space -
| you're right it will be used as backing store, at least for read-only
| segments, which can be discarded if memory is tight. Even if you mlock
| all executable in memory, I think there will be still at least one
| reference to this file, which will prevent freeing tmpfs memory.

Which is what I thought, and why I didn't do it that way in the
first place:-( That's 128+ Kbytes I'd rather have holding image
data:-(((

I've got shared libraries on the CF disk, it's fine (preferable) if
it pages out of them, but I don't want the program itself to reside
anywhere but in its memory image. (And I don't want to go writing to
the CF disk except for upgrades or sys admin stuff.)
- --
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCFTxvrPt1Sc2b3ikRAuy4AKCidKG/LYPDo9thwZag9S7JXLfSRACfUen6
N8ICW/n6BCR6OgJ5NMlW99Q=
=Fjct
-----END PGP SIGNATURE-----
