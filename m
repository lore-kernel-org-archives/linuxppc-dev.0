Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id 837A267A79
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Feb 2005 05:58:46 +1100 (EST)
Received: from [192.168.1.7] (wing [192.168.1.7]) (authenticated)
	by icarus.com (8.11.6/8.11.6) with ESMTP id j1IIwiA04235
	for <linuxppc-embedded@ozlabs.org>; Fri, 18 Feb 2005 10:58:44 -0800
Message-ID: <42163AE4.1090503@icarus.com>
Date: Fri, 18 Feb 2005 10:58:44 -0800
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <42152ADD.8040104@icarus.com>
	<20050218004327.GB10915@gate.ebshome.net>
	<20050218005905.GC10915@gate.ebshome.net>
In-Reply-To: <20050218005905.GC10915@gate.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
| On Thu, Feb 17, 2005 at 04:43:27PM -0800, Eugene Surovegin wrote:
|
|>On Thu, Feb 17, 2005 at 03:38:05PM -0800, Stephen Williams wrote:

|>>But if I do that, I want to remove the program from the directory
|>>after I start it, so that the file does not take up ram space. Will
|>>that actually work? I'm using exec(2) to execute the program file
|>>wherever it is downloaded. Will a subsequent unlink of the file
|>>have a result, or will the file continue to take up space as
|>>backing store for the executable?

|>I think unlink will remove the file from directory (so you won't be
|>able to see it with ls), but it will still continue to to take space -
|>you're right it will be used as backing store, at least for read-only
|>segments, which can be discarded if memory is tight. Even if you mlock
|>all executable in memory, I think there will be still at least one
|>reference to this file, which will prevent freeing tmpfs memory.
|
|
| A little correction, according to tmpfs doc, it lives completely in
| page cache, so I think memory is not wasted for unmodified sections of
| the loaded file (e.g. a second copy, when file is executed and loaded
| into user-space, isn't being made).
|
| But as usual, make some measurements first :)

So far as I can see in my simplistic tests, this still takes twice
as much memory as leaving the executable on a disk somewhere. This
seems to be an inevitable consequence of execve on Linux 2.4.x. That's
a bummer. Any other suggestions?


- --
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCFjrjrPt1Sc2b3ikRAjwvAKCogiZ5i+OHdsGskhsfC97+jxl/ygCgqAql
P77LUWxMW87T7ReXVg27fj8=
=j9KI
-----END PGP SIGNATURE-----
