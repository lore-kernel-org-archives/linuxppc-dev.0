Message-ID: <000c01c4188a$a2ce7790$0a14050a@JACKYLAM>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Buggy mmap()??
Date: Fri, 2 Apr 2004 16:15:17 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

    Currently,I write a small program to access /dev/mem. However, I find
that the data I get from mmap() is different from what I get from normal
read(). I have heard about there is some bug in mmap() in PPC. Is there any
patch to solve this? (I am using Monvista vista 3.0 kernel and libraries)

    The program I used is:

    void main(void)
    {
        int fd;
        char *addr;
        char c;

        fd=open("/dev/mem", O_RDONLY);
        addr=mmap(NULL, 0x00100000, PROT_READ, MAP_SHARED, fd, 0x00300000);
        printf("%x\n", *addr);

        lseek(fd, 0x00300000, SEEK_SET);
        read(fd, &c, 1);
        printf("%x\n", c);

        close(fd);
    }


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
