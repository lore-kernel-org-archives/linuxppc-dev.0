Date: Tue, 11 Jun 2002 10:18:34 +0800
From: "Daniel Lao" <laodx@gzjpg.com>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Why I can't bind the 1023 port?
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Message-Id: <200206111046140.SM00168@------>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I recently met some trouble with the "rcp" command. My "rcp" could not work
even if I have correctly configure the remote host.
When I run rcp in my local host, it print "Permission deny" to the terminal.

So I re-compiled rcp and debugged it by GDB. I found that it fail while tried to
bind the 1023 port for connecting with the remote rshd.

I though the 1023 port might be protected, and I wrote a program as below:

--- begin ---
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
extern int errno;

int main (int argc, char **argv)
{
    int s, rv;
    unsigned short port = 1023;
    struct sockaddr_in sin;

    s = socket (AF_INET, SOCK_STREAM, 0);
    if (s < 0)
    {
        perror ("socket");
        return errno;
    }

    sin.sin_family = AF_INET;
    sin.sin_addr.s_addr = INADDR_ANY;
    sin.sin_port = htons (port);
    rv = bind (s, (struct sockaddr *) &sin, sizeof (sin));
    if (rv < 0)
    {
        perror ("bind");
        return errno;
    }
}

--- end ---

The running result was that I could not bind these ports: 1023, 1022, ...
but it was success in bind 1024 port.
And while I su to as the super-user, I could bind all these ports!
I am wondering if the ports were really protected, and how can I use the ports?

Should anyone be kind to give me some advise?
:)

---
Daniel Lao
2002-06-11 10:17:58


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
