In-Reply-To: <Pine.LNX.4.10.9910041156210.15818-100000@lacrosse.corp.redhat.com>
Date: Tue, 5 Oct 1999 10:54:31 +0200
To: Elliot Lee <sopwith@redhat.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: esound for PPC
Message-Id: <19991005105431.012853@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 4, 1999, Elliot Lee <sopwith@redhat.com> wrote:

>That isn't the problem here. Apparently someone put a bad hack into the
>PPC sound driver that makes it default to little endian instead of big
>endian format, and esound is expecting that "native endian" on the sound
>device is "big endian", not "little endian".

I may be wrong, but to me, this looks like a bug in esound. The driver
seems capable of telling the application about it's current format and
can be told to change it. If esound does assumptions about the default
format instead of querying the driver, then esound is broken. (Also the
driver may have been switched to another format by an application before
esound takes control anyway. I don't remember which of /dev/audio or
/dev/dsp will keep the current setting so this may not be an issue).

I agree that the driver lacks a call to query about the native endian, so
if you really want to, you can add code to esound to force-switch to big
endian on PowerMac, but at least, it should be fixed to not rely on a
supposed default setting.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
