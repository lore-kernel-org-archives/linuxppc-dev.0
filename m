Date: Tue, 4 Apr 2000 17:46:24 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: "Henry A. Worth" <haworth@ncal.verio.com>
Subject: Re: Install on a Pismo (going bad)
Message-ID: <20000404174624.C7595@plato.localdomain.local>
References: <200004042110.OAA25686@ <200004042110.OAA25686@ shell1.ncal.verio.com> <20000404231952.A2266@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000404231952.A2266@suse.de>; from olh@suse.de on Tue, Apr 04, 2000 at 11:19:52PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 04, 2000 at 11:19:52PM +0200, Olaf Hering wrote:

> Drive Setup is buggy, it should be OpenSource ;)


very, and i have found that its bugginess surfaces much more when you
try and create non-macos partitions with it, my attempts to do so
resulted in crashes, corrupted partitions tables and other such
nastiness. (and `initialization failed' errors on what i know to be
good disks) so i have simply adopted the standard practice of using
each OS's native fdisk to create its partitions, ie use drive setup to
create macos partitions and mac-fdisk to create linux partitions.

what i tell people to do if they need to share a disk wtih macos is
first use drive setup to create 2 HFS partitions. the first being the
total size of all the linux partitions the user wants to create.  (say
they want 64MB / 1GB /usr 1GB /var 2GB /home, they would make the
first HFS partitions 5060MB)  then delete that partition with
mac-fdisk (aka pdisk under linux) and create the linux partitions
inside the newwly created `hole'

this seems reasonable to me, every single other OS/arch i have used
says to do this: BSD says use linux's `braindamaged' fdisk for its
partitions and BSD's fdisk for BSD partitions, linux says use DOS
fdisk for DOS partitions and its fdisk for linux partitions etc.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
