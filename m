Subject: Re: problems with smbfs on 2.4.18 kernel (ppc)
From: Bastien Nocera <hadess@hadess.net>
To: Urban Widmark <urban@teststation.com>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1020268150.25255.195.camel@dozo>
References: <Pine.LNX.4.33.0203050945100.21791-100000@cola.teststation.com>
	 <1020268150.25255.195.camel@dozo>
Date: 03 May 2002 03:06:25 +0100
Message-Id: <1020391586.13881.12.camel@dozo>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dammit,

I feel stupid now. The SAMBA version I grabbed off some MacOS X site
came with a borked smb.conf. There was a rule to veto some files only
used by MacOS X (resource forks). Here was the rule:

veto files = .*/Temporary Items/Desktop
*/TheFindByContentFolder/TheVolumeSettingsFolder/Network */

And the last bit actually vetoed all the directories, beginning with the
one at the bottom of the share. I still don't understand why smbclient
and the smb gnome-vfs method actually worked just fine with this share.

Urban, is this actually a bug ? I'll take this off linuxppc-dev now.

Cheers

On Wed, 2002-05-01 at 16:49, Bastien Nocera wrote:
<snip>
> I'm seeing this in ethereal:
> from laptop to SMB server: Transaction2 Request QUERY_PATH_INFORMATION,
> Path: \
> from SMB server back to laptop: Transaction2 Response
> QUERY_PATH_INFORMATION, Error: Directory not found
>
> However, smbclient seems to find it:
>
> smbclient //kara/backup1 -U hadess
> added interface ip=192.168.1.2 bcast=192.168.1.255 nmask=255.255.255.0
> Password:
> Domain=[IDORU] OS=[Unix] Server=[Samba 2.2.2]
> smb: \> ls
>   mp3s                                D        0  Wed Apr  3 06:38:08
> 2002

--
/Bastien Nocera
http://hadess.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
